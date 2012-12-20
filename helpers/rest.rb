#get_soap_route is used to retrieve the SOAP end point required for all SOAP interaction.

def get_soap_route
	update_token
	res = RestClient.get 'https://www.exacttargetapis.com/platform/v1/endpoints/soap?access_token=' + settings.oauthToken
	@res = JSON.parse(res)
	@results = JSON.pretty_generate(@res)
	settings.soapURI = @res["url"]
end

#update_token determine if the oAuth token is near/past expiration, and renews the token if required.

def update_token
	require 'date'
	til = Time.at(settings.exp) - Time.now
	left = (til/60).to_i
	p left
	if left < 5
		res = RestClient.post( "https://auth.exacttargetapis.com/v1/requestToken",
							  {
								:clientId => settings.clientId,
								:clientSecret => settings.clientSecret,
								:refreshToken => settings.refreshToken,
								:accessType => "offline"
							  })
		@res = JSON.parse(res)
		settings.oauthToken = @res["accessToken"]
		settings.exp = Time.now + @res["expiresIn"]
		settings.refreshToken = @res["refreshToken"]
	end	
end

#get_keys uses the JWT to get all required tokens, and stores them inside the app config settings in app.rb

def get_keys(jwt)
		p 'Setting the keys'
		@decodedJWT = JWT.decode(jwt.to_s,nil,settings.appSig)
		@jwtJSON = JSON.parse(@decodedJWT.to_json) 
		settings.oauthToken = @jwtJSON["request"]["user"]["oauthToken"]
		settings.internalOauthToken = @jwtJSON["request"]["user"]["internalOauthToken"]
		settings.refreshToken = @jwtJSON["request"]["user"]["refreshToken"]
		settings.jwt = jwt
		settings.exp = @jwtJSON["exp"]
end