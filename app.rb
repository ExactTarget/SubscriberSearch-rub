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
 set :appSig, 'p1dltvkuesxjmcktminrhinxyuxonn0yc2e0houqjoobkzuo4tiubaap2dqyve5rjyvr3ukhkhxa5pti3oubdfkmxlxbjweslhidhnckayaue3nor0visibfssjc44jiyw2utnp20lgyafczeqcsw5ijr3yyjwwj1rdbd2qjovavuaaftvsp503l1dqxaro23vaozawfp4hbw0en1aoygdmortohhw5nk1o1yoxcrezxuoq4nehsblplbtvlowt'
 set :clientId, '96tpxhqp4cp6fhvebvw73dzw'
 set :clientSecret, 'ZfFNf96jcUrDBeMpqjpWByNp'
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