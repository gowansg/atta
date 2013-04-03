require 'bundler'
require 'sinatra'
require 'openid'
require 'openid/store/filesystem'

class Atta < Sinatra::Base
  include OpenID

  enable :sessions
  #set :session_secret, ''

  helpers do
    def openid_consumer
      @openid_consumer ||= Consumer.new(session, 
        Store::Filesystem.new("#{File.dirname(__FILE__)}/openid/"))
    end

    def request_id_from(provider)
      unless session[:username] = ""
        begin
          id_request = openid_consumer.begin(provider)
        rescue
          "The provider: #{provider} could not be found."
        else
          realm = request.url.gsub(request.path, "")
          return_to = realm << "/login"
          redirect(id_request.redirect_url(realm, return_to))
        end
      end
    end

    def login_successful?
      response = openid_consumer.complete(params, "/")
      response.status == Consumer::SUCCESS
    end
  end

  before do
    redirect "/" unless session[:authenticated]
  end

  get "/" do
    redirect "/home" if session[:authenticated]
    "Login or Sign Up"
  end

  get "/login" do
    if request.query_string.include?("provider")
      provider = Rack::Utils.parse_query(request.query_string)["provider"]
      request_id_from(provider)
    elsif login_successful?
      session[:username] = 
        User.find(:username => request.query_string["username"])
    end

    redirect "/home"
  end

  get "/home" do

  end
end