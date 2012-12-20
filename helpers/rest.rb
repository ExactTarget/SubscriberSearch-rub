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