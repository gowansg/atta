require "test/unit"
require "rack/test"
require "json"
require_relative "../routes/api"

set :environment, :test

describe Atta::Api do
  include Test::Unit::Assertions
  include Rack::Test::Methods

  def app
    Atta::Api
  end

  after :each do
    body = last_response.body
    body.should_not eql nil
    body.should_not eql nil.to_json
    body.should_not eql [].to_json
  end

  # context "/oauth/authorize" do
  #   it "presents the resource owner with a notifcation about authorizing " <<
  #      "the thrid party application making the request" do

  #   end

  #   it "notifies the resource owner the request is invalid if the " << 
  #      ":client_id parameter does belong to any regisitered clients" do

  #   end

  #   it "notifies the resource owner the request is invalid if the " <<
  #      ":redirect_uri doesn't match the client's regisitered redirect_uri " do

  #   end
  # end

end