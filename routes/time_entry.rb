class Atta::Api < Sinatra::Base
  delete "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/" << 
         ":time_entry_id" do
    time_entry = TimeEntry.get(params[:time_entry_id])
    time_entry.destroy.to_json
  end
      get "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries" do
    Task.get(params[:task_id]).time_entries.to_json
  end

  get "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/" <<
      ":time_entry_id" do
    TimeEntry.get(params[:time_entry_id]).to_json
  end

  post "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries" do
    task = Task.get(params[:task_id])
    time_entry = TimeEntry.create(:start_time => params[:start_time],
                                  :end_time => params[:end_time],
                                  :type => params[:type],
                                  :task => task)
    if time_entry.valid?
      task.time_entries << time_entry
      task.save
      time_entry.to_json
    end
  end

  put "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/" <<
      ":time_entry_id" do
    time_entry = TimeEntry.get(params[:time_entry_id])
    time_entry.update(:end_time => params[:end_time] || time_entry.end_time)
    time_entry.to_json if time_entry.valid?
  end
end