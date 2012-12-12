#Class to initialize the ET SOAP client through Savon, and create the authorization header required in the SOAP packet. 
class SoapClient

#Create the SOAP client with Savon.  
	
	def self.client 
	
 	 return Savon::Client.new do |wsdl, http, wsse|
			wsdl.document = settings.wsdl
			wsdl.endpoint = settings.soapURI
			wsse.credentials('*', '*')			
			end
			
	end

#Creates the object for Authorization.

	def self.auth(token)
			p "Authorizing"
			p token
			
		   obj = {
				'oAuth' => {
					'oAuthToken' => token
				}
			}
			
			obj[:attributes!] = { 'oAuth' => { 'xmlns' => 'http://exacttarget.com' } }
			
			return obj
	end
	
end


#Class to do specific SOAP calls - Retrieve and Update

class ETWSDL 

	attr_accessor :args

#Retrieve initializes the SOAP client, and accepts an argument object to define the properties and object type.  Args will also allow for a filter object to be passed.
	def self.retrieve (args = {})
		
		client = SoapClient.client
		
#Defining default arguments, in case no arguments are passed.

		args[:objType] ||= 'Subscriber'
		args[:props] ||= ['ID','CreatedDate','EmailAddress','SubscriberKey','Status']

		return  client.request :retrieve  do |soap|
		
#Add authorization header.					

			soap.header = SoapClient.auth(args[:token])
			
			soap.input = [
				("tns:RetrieveRequestMsg")
			]
			
			retrieveRequest = {}

#Define object type and properties to be passed in SOAP packet.
			
			objType = {'ObjectType' => args[:objType]}
			props = {'Properties' => args[:props]}

#Creating the retrieve object.
			
			retrieveRequest = retrieveRequest.merge! objType
			retrieveRequest = retrieveRequest.merge! props
			
#If the filter object is passed, this section will use the object to build out the filter portion of the SOAP call.			
			
			if args[:filter]
				filter = {'Filter' => args[:filter], :attributes! => { 'Filter' => { "xsi:type" => "tns:SimpleFilterPart" } } }
				retrieveRequest = retrieveRequest.merge! filter
			end

#Complete the retrieve body of the SOAP packet.		

			soap.body = {'RetrieveRequest' => retrieveRequest}
				
		end
	end

#Update initializes the SOAP client, and accepts an argument object to 
	
	def self.update (args = {})
	
		
		args[:objType] ||= 'Subscriber'

			client = SoapClient.client
			
			response =  client.request :update  do |soap|
			soap.header = SoapClient.auth(args[:token])
			
			soap.input = [
				("tns:UpdateRequest")
			]
			
#Complete the update body of the SOAP packet.
			
			soap.body = {
					'Options/' => nil,
					'Objects' => args[:objects],
					:attributes! => {'Objects' => { 'xsi:type' => 'tns:'+args[:objType] } }
					}
						
		end
	end
	 
end

#get_subscribers is the method to call the retrieve request to get all subscribers, or filter by the search functionality passed by the data grid.

def get_subscribers ( filter = nil )
		
#Passing an empty arg object and using only the defaults created in the ETWSDL.retrieve

		args ={}

#If a filter is passed, create the object here.

		unless filter == nil
			filterHash = {'Property' => 'EmailAddress', 'SimpleOperator' => 'like', 'Value' => filter}
			args[:filter] = filterHash
		end
		args[:token] = settings.internalOauthToken
		
#Return SOAP response as hash	
	
		return format_response(ETWSDL.retrieve(args).to_hash)

end

#get_subscriber_by_id returns the detail information about a specific subscriber.

def get_subscriber_by_id ( filter = nil )
	
#Only returns a result if there is a filter passed.

		unless filter == nil
			filterHash = {'Property' => 'ID', 'SimpleOperator' => 'equals', 'Value' => filter}
			args={}
			args[:filter] = filterHash
			args[:token] = settings.internalOauthToken

#Call format_response to return a usable hash with the exact information		
			return format_response(ETWSDL.retrieve(args).to_hash)
		end

end

#update_subscriber takes the id of a specific subscriber, and changes the status based on the input.

def update_subscriber ( id, status )

		objectHash = {'ID' => id , 'Status' => status}
		args = {}
		args[:token] = settings.internalOauthToken
		args[:objects] = objectHash

		return ETWSDL.update(args).to_hash
	
end

#format_response takes the SOAP packet and cleans it up for consumption - this isn't required, but makes things easier on the client side.
def format_response (response)

		obj = {}
		
		subs = response[:retrieve_response_msg][:results]
		
		if subs.kind_of?(Array)
		 	obj[:subscribers] = []	
			subs.each do |sub|
	
#If you have attributes assigned, and wish to use those, this is a snippet to select those attributes.
				#fname = (sub[:attributes].select {|s| s[:name] === "First Name" })[0][:value]
				#lname = (sub[:attributes].select {|s| s[:name] === "Last Name" })[0][:value]
			
				date = sub[:created_date]
				date = date.strftime("%m/%d/%Y - %I:%M%p")
			
   				hash = { :ID => sub[:id] , :EmailAddress => sub[:email_address] , :SubscriberKey => sub[:subscriber_key] , :CreatedDate => date , :Status => sub[:status] }
   			
				obj[:subscribers].push(hash)
	
			end
		
		else
			obj[:subscriber] = []
			
			sub = subs
			date = sub[:created_date]
			date = date.strftime("%m/%d/%Y - %I:%M%p")
			
   			hash = { :ID => sub[:id] , :EmailAddress => sub[:email_address] , :SubscriberKey => sub[:subscriber_key] , :CreatedDate => date , :Status => sub[:status] }
   			
			obj[:subscriber].push(hash)
			
		end
		
		return obj

end

