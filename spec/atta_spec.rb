#require "rspec"
require "test/unit"
require "rack/test"
require_relative "../lib/atta"

set :environment, :test

describe "Another Time Tracking App" do
  include Test::Unit::Assertions
  include Rack::Test::Methods

  def app
    Atta.new
  end

  before :all do
    @project = Project.new( :id => 10, :name  => "Spec Project", 
      :tasks => [
        Task.new(:id => 1, :name => "Writing Specs", :project_id => 10, 
          :time_entries => [
            TimeEntry.new(:task_id => 1, :start_time => Time.now - 4, 
              :end_time => Time.now - 3)
          ]),
        Task.new(:id => 2, :name => "Running Specs", :project_id => 10, 
          :time_entries => [
            TimeEntry.new(:task_id => 2, :start_time => Time.now - 1.5, 
              :end_time => Time.now - 1.25),
            TimeEntry.new(:task_id => 2, :start_time => Time.now - 1,
              :end_time => Time.now - 0.9)
          ])
        ])
  end

  describe "GET/" do
    context "when user is unauthenticated" do
      it "displays login/sign up page" do
        get "/"
        last_response.should be_ok
        last_response.body.should == "Login or Sign Up"
      end
    end

    context "when user is authenticated" do
      it "navigates to the user's home page" do
        get "/", {}, "rack.session" => {:authenticated => true}
        follow_redirect!
        assert_equal("http://" << Rack::Test::DEFAULT_HOST << "/home",
          last_request.url)
        assert last_response.ok?
      end
    end
  end

  it "uses open id to authenticate user" do
    get "/login?provider=https://www.google.com/accounts/o8/id."
    follow_redirect!
    assert_equal("http://" << Rack::Test::DEFAULT_HOST << "/home", 
      last_request.url)
  end

  it "returns a list of projects for the current user" do

  end
end