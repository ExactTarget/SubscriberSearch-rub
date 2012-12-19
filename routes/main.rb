# encoding: utf-8
	
class SubscriberSearch < Sinatra::Application

#Main route to show application. This gets the SOAP route, and displays the main template.

	get "/" do
		p settings.oauthToken
		p settings.internalOauthToken
		p settings.refreshToken
		p settings.jwt
		p settings.exp
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