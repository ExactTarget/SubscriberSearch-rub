# encoding: utf-8
	
class SubscriberSearch < Sinatra::Application

#Main route to show application. This gets the SOAP route, and displays the main template.

	get "/" do
		get_soap_route
		@title = "Subscriber Search"
		slim :main
	end

#Login initializes the app, and sets all keys to be used.  This is the first page called by the IMH.

	post "/login" do
		get_keys(params[:jwt])
		redirect to('/')
	end

#Currently unused - but this would be used to clean up anything on logout.
	
	post "/logout" do

	end

#/subscribers route returns all subscribers or filters based on search box, and returns them to the datasource.js for the data grid.
	
	get "/subscribers" do
		if params['searchString']
		@result = get_subscribers(params['searchString']).to_json
		else
		@result = get_subscribers.to_json
		end
	end

#/subscriber/:id route gets a specific subscriber and returns the data to the subscriberDetail template.
	
	get "/subscriber/:id" do
		sub = get_subscriber_by_id(params[:id])
		sub = sub[:subscriber][0]
		@EmailAddress = sub[:EmailAddress]
		@SubscriberKey = sub[:SubscriberKey]
		@CreatedDate = sub[:CreatedDate]
		@Status = sub[:Status]
		@id = sub[:ID]
		slim :subscriberDetails, :layout => false
	end

#/subscriber/update/:id/:status takes the ID and Status of a subscriber and runs the update SOAP call.
	
	get "/subscriber/update/:id/:status" do
		@result = update_subscriber( params[:id], params[:status] )
	end

# sidebar runs the sidebar template code in the Main template.	
	def sidebar
		@SidebarTitle = "Subscriber Details"
		slim :sidebar, :layout => false
	end

# grid runs the grid template inside the main template.
	
	def grid
		@gridTitle = "Subscriber Listings"
		@searchPlaceholder = "Search for Subscribers"
		slim :grid, :layout => false
	end
	

end