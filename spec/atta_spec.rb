# require "test/unit"
# require "rack/test"
# require_relative "../lib/atta"

# set :environment, :test

# describe "Another Time Tracking App" do
#   include Test::Unit::Assertions
#   include Rack::Test::Methods

#   def app
#     Atta.new
#   end

  # before :all do
  #   @transaction = 
  #     DataMapper::Transaction.new(DataMapper.repository(:default).adapter)

  #   @transaction.begin

  #   @user = User.first_or_create(:username => "batman")
  #   @project = @user.create_project(:name => "Spec Writing Project")   
  #   @project.save.should eql true
  # end

  # after :all do
  #   @transaction.rollback
  # end

#   describe "GET /" do
#     context "when user is unauthenticated" do
#       it "displays login/sign up page" do
#         get "/"
#         last_response.should be_ok
#         last_response.body.should == "Login or Sign Up"
#       end
#     end

#     context "when user is authenticated" do
#       it "navigates to the user's home page" do
#         get "/", {}, "rack.session" => { :username => @user.username }
        
#         follow_redirect!
        
#         assert_equal("http://" << Rack::Test::DEFAULT_HOST << "/home",
#           last_request.url)
        
#         assert last_response.ok?
#       end
#     end
#   end

#   it "uses open id to authenticate user" do
#     # get "/login?provider=https://www.google.com/accounts/o8/id."
#     # follow_redirect!
#     # assert_equal("http://" << Rack::Test::DEFAULT_HOST << "/home", 
#     #   last_request.url)
#   end

#   it "returns a list of projects for the current user" do
#     get "/", {}, "rack.session" => { :username => @user.username }

#     @project.should_not eql nil
#     @project.users.get(1).id.should eql 1
#   end
# end