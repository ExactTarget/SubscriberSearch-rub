# encoding: utf-8
	
class SubscriberSearch < Sinatra::Application

#Main route to show application. This gets the SOAP route, and displays the main template.

	get "/" do
		get_keys(settings.jwt)
		@title = "Subscriber Search"
		slim :main
	end

#Login initializes the app, and sets all keys to be used.  This is the first page called by the IMH.

	post "/login" do
		settings.jwt = (params[:jwt])
		redirect to('/')
	end

#Currently unused - but this would be used to clean up anything on logout.
	
	post "/logout" do

	end
		

end