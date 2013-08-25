require "sinatra"
require "sinatra/contrib"
require "openid"
require "json"

module Atta
  class Api < Sinatra::Base
    register Sinatra::RespondWith
    respond_to :json, :xml
    
    # before "/users/:user_id/*" do
    #   resource_owner_id = AccessToken.get(params[:access_token]).user_id
    #   halt 403 unless params[:user_id] == resource_owner_id
    # end
  end
end

require_relative "tag"
require_relative "user"
require_relative "project"
require_relative "task"
require_relative "time_entry"
require_relative "oauth2"