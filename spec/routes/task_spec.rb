describe Atta::Api do
  context "/users/:user_id/projects/:project_id/tasks" do
    it "returns all tasks belonging to the specified project" do
      user = Fabricate(:user)
      project = Fabricate(:project_with_tasks, users: [user])
      get "/users/#{user.id}/projects/#{project.id}/tasks"
      last_response.body.should eql project.tasks.to_json
    end
  end

  context "/users/:user_id/projects/:project_id/tasks/:task_id" do
    it "returns the specified task" do
      user = Fabricate(:user)
      project = Fabricate(:project_with_tasks, users: [user])
      get "/users/#{user.id}/projects/#{project.id}/tasks/" <<
          "#{project.tasks.first.id}"
      last_response.body.should eql project.tasks.first.to_json
    end
  end
  
  context "/users/:user_id/projects/:project_id/tasks" do
    it "returns a task after creating and assigning it to the " << 
       "given project" do
      project = Fabricate(:project)
      user_id = project.users.first.id
      post "/users/#{user_id}/projects/#{project.id}/tasks",
           Fabricate.build(:task, name: "POST task").attributes
      last_response.body.should eql project.tasks.last.to_json
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
end