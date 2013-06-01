require "test/unit"
require "rack/test"
require "json"
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
    @project = Fabricate(:project)
    @tags = []
    10.times { @tags << Fabricate(:tag) }
  end

  after :each do
    body = last_response.body
    body.should_not eql nil
    body.should_not eql nil.to_json
    body.should_not eql [].to_json
  end

  describe "GET" do
    context "/tags" do
      it "returns all tags" do
        get "/tags"
        last_response.body.should eql @tags.to_json
      end
    end
    
    context "/tags/:tag_id" do
      it "returns the tag with the specified id" do
        @tags.each_index do |i|
          get "/tags/#{i + 1}"
          last_response.body.should eql @tags[i].to_json
        end
      end
    end 

    context "/users/:user_id" do
      it "returns the user with the specified id" do
        get "/users/#{@user.id}"
        last_response.body.should eql @user.to_json
      end
    end

    context "/users/:user_id/projects" do
      it "returns all the projects the specified user contributes to" do
        projects = [
          Fabricate(:project, users: [@user]), 
          Fabricate(:project, users: [@user])
        ]
        get "/users/#{@user.id}/projects"
        last_response.body.should eql projects.to_json
      end
    end

    context "/users/:user_id/projects/:project_id" do
      it "returns the user's project matching the specified project id" do
        get "/users/#{@project.users.first.id}/projects/#{@project.id}"
        last_response.body.should eql @project.to_json
      end    
    end

    context "/users/:user_id/projects/:project_id/contributors" do
      it "returns all the contributors to the specfied project" do
        project = Fabricate(:project_with_five_users)
        get "/users/#{project.users[0].id}/projects/#{project.id}/contributors"
        last_response.body.should eql project.users.to_json
      end    
    end

    context "/users/:user_id/projects/:project_id/tags" do
        it "returns all of the specified project's tags" do
        project = Fabricate(:project_with_tags, users: [@user])
        get "/users/#{@user.id}/projects/#{project.id}/tags"
        last_response.body.should eql project.tags.to_json
      end
    end

    context "/users/:user_id/projects/:project_id/tasks" do
      it "returns all tasks belonging to the specified project" do
        project = Fabricate(:project_with_tasks, users: [@user])
        get "/users/#{@user.id}/projects/#{project.id}/tasks"
        last_response.body.should eql project.tasks.to_json
      end
    end

    context "/users/:user_id/projects/:project_id/tasks/:task_id" do
      it "returns the specified task" do
        project = Fabricate(:project_with_tasks, users: [@user])
        get "/users/#{@user.id}/projects/#{project.id}/tasks/" <<
            "#{project.tasks.first.id}"
        last_response.body.should eql project.tasks.first.to_json
      end
    end

    context "/users/:user_id/projects/:project_id/tasks/:task_id/" << 
            "time_entries" do
      it "returns all time entries for the specified task" do
        project = Fabricate(:project_with_time_entries)
        get "/users/#{project.users.first.id}/projects/#{project.id}/tasks/" <<
            "#{project.tasks.first.id}/time_entries"
        last_response.body.should eql project.tasks.first.time_entries.to_json
      end
    end

    context "/users/:user_id/projects/:project_id/tasks/:task_id/" << 
            "time_entries/:time_entry_id" do
      it "returns the specified time entry" do
        project = Fabricate(:project_with_time_entries)
        task = project.tasks.first
        get "/users/#{project.users.first.id}/projects/#{project.id}/tasks/" <<
            "#{task.id}/time_entries/#{task.time_entries.first.id}"
        last_response.body.should eql task.time_entries.first.to_json
      end
    end
  end

  describe "POST" do
    context "/tags" do
      it "returns the newly created tag" do
        name = "test"
        post "/tags", :name => name
        last_response.body.should eql Tag.first(:name => name).to_json
      end
    end

    context "/users" do
      it "creates and returns a new user" do
        user = Fabricate.build(:user, username: "POST User")
        post "/users", user.attributes
        last_response.body.should eql User.first(:email => user.email).to_json
      end
    end

    context "/users/:user_id/projects" do
      it "creates and returns the project for the specified user" do
        post "/users/#{@user.id}/projects", 
             Fabricate.build(:project, name: "POST project").attributes
        last_response.body.should eql @user.projects.last.to_json
      end
    end

    context "/users/:user_id/projects/:project_id/contributors" do
    end

    context "/users/:user_id/projects/:project_id/tags" do
    end

    context "/users/:user_id/projects/:project_id/tasks" do
      it "returns a task after creating and assigning it to the " << 
         "given project" do
        post "/users/#{@user.id}/projects/#{@user.projects.first.id}/tasks",
             Fabricate.build(:task, name: "POST task").attributes
        last_response.body.should eql @user.projects.first.tasks.last.to_json
      end
    end

    context "/users/:user_id/projects/:project_id/tasks/:task_id/" << 
            "time_entries" do
      it "returns a time entry after creating it and assigning it to the " << 
         "given task" do
        project = @user.projects.first
        post "/users/#{@user.id}/projects/#{project.id}/tasks/" << 
             "#{project.tasks.first.id}/time_entries",
             Fabricate.build(:time_entry).attributes
        
        last_response.body.should eql project.tasks
          .first
          .time_entries
          .last
          .to_json
      end
    end
  end

  describe "PUT" do
    context "/tags/:tag_id" do
      it "returns the updated tag" do
        tag = Tag.first
        name = tag.name = "updated tag"
        put "/tags/#{tag.id}", tag.attributes
        last_response.body.should eql tag.to_json
        tag.name.should eql name
      end
    end

    context "/users/:user_id" do
      it "returns the updated user" do
        @user.active = false
        @user.username = username = "another test passed"
        put "/users/#{@user.id}", @user.attributes
        last_response.body.should eql @user.to_json
        @user.active.should eql false
        @user.username.should eql username
      end
    end

    context "/users/:user_id/projects/:project_id" do
      it "returns the updated project" do
        name = "an updated name"
        description = "an updated description"
        put "/users/#{@project.users.first.id}/projects/#{@project.id}",
            :name => name,
            :description => description
        @project.reload
        last_response.body.should eql @project.to_json
        @project.name.should eql name
        @project.description.should eql description
      end
    end

    context "/users/:user_id/projects/:project_id/tasks/:task_id" do
      it "updates the specified task" do
        task = Fabricate(:task, name: "put test")
        project = task.project
        user = project.users.first
        updated_name = "put test 2"
        put "/users/#{user.id}/projects/#{project.id}/tasks/#{task.id}",
            :name => updated_name
        task.reload
        last_response.body.should eql task.to_json
        task.name.should eql updated_name
      end
    end

    context "/users/:user_id/projects/:project_id/tasks/:task_id/" <<
            "time_entries/:time_entry_id" do
      it "updates the specified time entry" do
        time_entry = Fabricate(:time_entry)
        task = time_entry.task
        user = task.project.users.first
        end_time = Time.now + (60 * 60)
        put "/users/#{user.id}/projects/#{task.project.id}/tasks/#{task.id}/" <<
            "time_entries/#{time_entry.id}", :end_time => end_time

        time_entry.reload
        last_response.body.should eql time_entry.to_json
        time_entry.end_time = end_time
      end
    end
  end

  describe "DELETE" do
    context "/tags/:tag_id" do
      it "deletes the specified tag" do
        task = Fabricate(:task_with_tags, description: "delete tag task")
        tag = task.tags.first
        delete "/tags/#{tag.id}"
        TagTask.all(:tag => tag).should == []
        Tag.get(tag.id).should eql nil
        Task.get(task.id).should eql task
        task.should_not eql nil
        last_response.body.should eql true.to_json
      end
    end

    context "/users/:user_id" do
      it "deletes the specified user" do
        user = Fabricate(:user, username: "delete test")
        User.get(user.id).should_not eql nil
        delete "/users/#{user.id}"
        last_response.body.should eql true.to_json
        User.get(user.id).should eql nil
      end
    end

    context "/users/:user_id/projects/:project_id/" do
      it "deletes the specified project" do
        project = Fabricate(:project_with_tasks, name: "project delete test")
        Project.get(project.id).should_not eql nil
        delete "/users/#{project.users.first.id}/projects/#{project.id}"
        last_response.body.should eql true.to_json
        Project.get(project.id).should eql nil
      end
    end

    context "/users/:user_id/projects/:project_id/contributors/" << 
            ":contributor_id" do
      it "removes the specified user from the project" do
        project = Fabricate(:project_with_five_users)
        user = project.users.first
        delete "/users/#{user.id}/projects/#{project.id}/contributors/#{user.id}"
        last_response.body.should eql true.to_json
        project.reload
        project.users.include?(user).should eql false
      end
    end

    context "/users/:user_id/projects/:project_id/tags/:tag_id" do
      it "removes the tag's association from the project" do
        project = Fabricate(:project_with_tags)
        user = Fabricate(:user)
        project.users << user
        tag = project.tags.first
        delete "/users/#{user.id}/projects/#{project.id}/tags/#{tag.id}"
        last_response.body.should eql true.to_json
        project.reload
        project.tags.include?(tag).should eql false
      end
    end

    context "/users/:user_id/projects/:projcet_id/tasks/:task_id" do
      it "deletes the task" do
        project = Fabricate(:project_with_tasks)
        user = project.users.first
        task = project.tasks.first
        delete "/users/#{user.id}/projects/#{project.id}/tasks/#{task.id}"
        last_response.body.should eql true.to_json
        project.reload
        project.tasks.include?(task).should eql false
      end
    end

    context "/users/:user_id/projects/:project_id/tasks/:task_id/" << 
            "time_entries/:time_entry_id" do
      it "deletes the specified time entry" do
        project = Fabricate(:project_with_time_entries)
        project.tasks << task = Fabricate(:task_with_time_entries)
        time_entry = task.time_entries.first
        delete "/users/#{project.users.first.id}/projects/#{project.id}/" <<
               "tasks/#{task.id}/time_entries/#{time_entry.id}"
        last_response.body.should eql true.to_json
        task.reload
        task.time_entries.include?(time_entry).should eql false
      end
    end
  end
end