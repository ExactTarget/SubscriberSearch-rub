# encoding: utf-8

require "sinatra"
require "slim"
require "jwt"
require "json"
require 'rest_client'
require 'savon'
require 'date'

#Configuration requirements used by the app.
configure do
 set :appSig, 'YOUR APP SIG HERE'
 set :clientId, 'YOUR CLIENT ID HERE'
 set :clientSecret, 'YOUR CLIENT SECRET HERE'
 set :oauthToken, nil
 set :internalOauthToken, nil
 set :refreshToken, nil
 set :jwt, nil
 set :soapURI, nil
 set :exp, nil
 set :wsdl, "https://webservice.s4.exacttarget.com/ETFramework.wsdl"
 
 set :protection, :except => :frame_options
 
end


class SubscriberSearch < Sinatra::Application
	enable :sessions
end

require_relative 'helpers/init'
require_relative 'models/init'
require_relative 'routes/init'