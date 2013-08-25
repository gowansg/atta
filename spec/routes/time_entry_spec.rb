describe Atta::Api do
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

  context "/users/:user_id/projects/:project_id/tasks/:task_id/" << 
          "time_entries" do
    it "returns a time entry after creating it and assigning it to the " << 
       "given task" do
      project = Fabricate(:project_with_tasks)
      user = project.users.first
      post "/users/#{user.id}/projects/#{project.id}/tasks/" << 
           "#{project.tasks.first.id}/time_entries",
           Fabricate.build(:time_entry).attributes
      
      last_response.body.should eql project.tasks
        .first
        .time_entries
        .last
        .to_json
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