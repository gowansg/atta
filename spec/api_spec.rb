require "test/unit"
require "rack/test"
require 'json'
require_relative "../api/api"

set :environment, :test

describe API do
  include Test::Unit::Assertions
  include Rack::Test::Methods

  def app
    API
  end

  before :all do
    @user = Fabricate(:user)
    @tags = []
    10.times { @tags << Fabricate(:tag) }
  end

  describe "GET" do
    context "/tags" do
      it "returns all tags" do
        get "/tags"
        last_response.body.should == @tags.to_json
      end
    end
    
    context "/tags/:tag_id" do
      it "returns the tag with the specified id" do
        @tags.each_index do |i|
          get "/tags/#{i + 1}"
          last_response.body.should == @tags[i].to_json
        end
      end
    end 

    context "/users/:user_id" do
      it "returns the user with the specified id" do
        get "/users/#{@user.id}"
        last_response.body.should eql @user.to_json
      end
    end

    context "users/:user_id/projects" do
      it "returns all the projects the specified user contributes to" do
        @user.projects = [
          Fabricate(:project_x, users: [@user]), 
          Fabricate(:project_runway, users: [@user])
        ]

        get "/users/#{@user.id}/projects"
        last_response.body.should eql @user.projects.to_json
      end
    end

    context "users/:user_id/projects/:project_id" do
      it "" do

      end    
    end

    context "users/:user_id/projects/:project_id/contributors" do
      it "" do

      end    
    end

    context "users/:user_id/projects/:project_id/tasks" do
      it "" do

      end
    end

    context "/users/:user_id/projects/:project_id/tasks/:task_id" do
      it "" do

      end
    end

    context "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries" do
      it "" do

      end
    end

    context "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/" << 
      ":time_entry_id" do
 
      it "" do

      end
    end
  end

  describe "POST" do

  end
end