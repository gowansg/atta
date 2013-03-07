require './lib/atta'
require 'rspec'
require 'test/unit'
require 'rack/test'

set :environment, :test

describe "Another Time Tracking App" do
  include Test::Unit::Assertions
  include Rack::Test::Methods

  def app
  	Atta.new
  end

  it "displays login/sign up page for unauthenticated user" do
    get "/"
    last_response.should be_ok
    last_response.body.should == 'Login or Sign Up'
  end

  it "uses Open Id to login user" do
    get "/login?provider=https://www.google.com/accounts/o8/id."
    
    follow_redirect!

    assert_equal("http://" << Rack::Test::DEFAULT_HOST << "/home", 
      last_request.url)
  end

  it "navigates to home page for authenticated user" do
    get "/", {}, "rack.session" => {:authenticated => true}

    follow_redirect!

    assert_equal("http://" << Rack::Test::DEFAULT_HOST << "/home",
     last_request.url)
    
    assert last_response.ok?
  end
end