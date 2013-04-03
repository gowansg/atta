require "test/unit"
require "rack/test"

describe Api do
  include Test::Unit::Assertions
  include Rack::Test::Methods

  def app
    Api.new
  end

  describe "GET" do
    context "/tags" do
      it "returns all tags" do

      end
    end
    
    context "/tags/:tag_id" do
      it "returns the tag with the specified id" do

      end
    end 

    context "/users/:user_id" do
      it "returns the user with the specified id" do

      end
    end

    context "users/:user_id/projects" do
      it "" do

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