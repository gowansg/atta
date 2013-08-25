class Atta::Api < Sinatra::Base
  delete "/users/:user_id/projects/:project_id/tasks/:task_id" do
    task = Task.get(params[:task_id])
    task.tags.all.destroy
    task.time_entries.all.destroy
    task.destroy.to_json
  end

  get "/users/:user_id/projects/:project_id/tasks" do
    Project.get(params[:project_id]).tasks.to_json
  end

  get "/users/:user_id/projects/:project_id/tasks/:task_id" do
    Task.get(params[:task_id]).to_json
  end

  post "/users/:user_id/projects/:project_id/tasks" do
    project = Project.get(params[:project_id])
    task = Task.create(:name => params[:name],
                       :description => params[:description],
                       :project => project)
    if task.valid?
      project.tasks << task
      project.save
      task.to_json
    end
  end

  put "/users/:user_id/projects/:project_id/tasks/:task_id" do
    task = Task.get(params[:task_id])
    task.update(:name => params[:name] || task.name, 
                :description => params[:description] || task.description)
    task.to_json if task.valid?
  end
end