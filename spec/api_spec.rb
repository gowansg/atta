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
    @project = Fabricate(:project, :users => [@user])
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
        projects = [
          Fabricate(:project_x, users: [@user]), 
          Fabricate(:project_with_three_tasks, users: [@user])
        ]
        @user.projects = projects
        @user.save
        get "/users/#{@user.id}/projects"
        last_response.body.should eql projects.to_json
      end
    end

    context "users/:user_id/projects/:project_id" do
      it "returns the user's project matching the specified project id" do
        @user.projects = [@project]
        @user.reload
        get "users/#{@user.id}/projects/#{@project.id}"
        last_response.body.should eql @project.to_json
      end    
    end

    context "users/:user_id/projects/:project_id/contributors" do
      it "returns all the contributors to the specfied project" do
        @user.projects = [Fabricate(:project_with_five_users)]
        @user.reload
        get "users/#{@user.id}/projects/#{@user.projects.first.id}/contributors"
        last_response.body.should eql @user.projects.first.users.to_json
      end    
    end

    context "users/:user_id/projects/:project_id/tags" do
        it "returns all of the specified projects tags" do
        @user.projects = [Fabricate(:project_with_tags)]
        @user.reload
        get "users/#{@user.id}/projects/#{@user.projects.first.id}/tags"
        last_response.body.should eql @user.projects
          .first
          .tasks
          .select { |t| t.tags }
          .to_json
      end
    end

    context "users/:user_id/projects/:project_id/tasks" do
      it "returns all tasks belonging to the specified project" do
        @user.projects = [Fabricate(:project_with_three_tasks)]
        @user.reload
        get "users/#{@user.id}/projects/#{@user.projects.first.id}/tasks"
        last_response.body.should eql @user.projects.first.tasks.to_json
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