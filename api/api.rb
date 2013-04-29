require "sinatra"
require "openid"
require "json"

class API < Sinatra::Base

  # All DELETE requests
  delete "/tags/:tag_id" do

  end

  delete "/users/:user_id" do

  end

  delete "/users/:user_id/projects/:project_id" do

  end

  delete "/users/:user_id/projects/:project_id/contributors/:contributor_id" do

  end

  delete "/users/:user_id/projects/:project_id/tags/:tag_id" do

  end

  delete "/users/:user_id/projects/:project_id/tasks/:task_id/" do

  end

  delete "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/" << 
    ":time_entry_id" do

  end

  #All GET requests
  get "/" do

  end
  
  get "/tags" do
    Tag.all.to_json
  end

  get "/tags/:tag_id" do
    Tag.get(params[:tag_id]).to_json
  end
  
  get "/users/:user_id" do
    User.get(params[:user_id]).to_json
  end

  get "/users/:user_id/projects" do
    User.get(params[:user_id]).projects.to_json
  end

  get "/users/:user_id/projects/:project_id" do
    Project.get(params[:project_id]).to_json  
  end

  get "/users/:user_id/projects/:project_id/contributors" do
    Project.get(params[:project_id]).users.to_json
  end

  get "/users/:user_id/projects/:project_id/tags" do
    Project.get(params[:project_id]).tasks.collect { |t| t.tags }.to_json
  end

  get "/users/:user_id/projects/:project_id/tasks" do
    Project.get(params[:project_id]).tasks.to_json
  end

  get "/users/:user_id/projects/:project_id/tasks/:task_id" do
    Task.get(params[:task_id]).to_json
  end

  get "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries" do
    Task.get(params[:task_id]).time_entries.to_json
  end

  get "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/" <<
    ":time_entry_id" do
    TimeEntry.get(params[:time_entry_id]).to_json
  end

  #All POST requests
  post "/tags" do
    tag = Tag.create(:name => params[:name],
      :tasks => params[:tasks] || [])
    tag.to_json if tag.valid?
  end

  post "/users" do
    user = User.create(:username => params[:username], :email => params[:email])
    user.to_json if user.valid?
  end

  post "/users/:user_id/projects" do
    user = User.get(params[:user_id])
    project = Project.create(:name => params[:name],
      :description => params[:description],
      :users => [user])
    project.to_json if project.valid?
  end

  post "/users/:user_id/projects/:project_id/contributors" do
  
  end

  post "/users/:user_id/projects/:project_id/tags" do

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

  #All PUT requests
  put "/tags/:tag_id" do
    tag = Tag.get(params[:tag_id])
    tag.update(:name => params[:name] || tag.name)
    tag.to_json if tag.valid?
  end

  put "/users/:user_id" do
    user = User.get(params[:user_id])
    user.update(:username => params[:username] || user.username,
      :active => params[:active] || user.active,
      :email => params[:email] || user.email)
    user.to_json if user.valid?
  end

  put "/users/:user_id/projects/:project_id" do
    project = Project.get(params[:project_id])
    project.update(:name => params[:name] || project.name,
      :description => params[:description] || project.description,
      :deleted => params[:deleted] || project.deleted)
    project.to_json if project.valid?
  end

  put "/users/:user_id/projects/:project_id/contributors/:contributor_id" do

  end
  
  put "/users/:user_id/projects/:project_id/tags/:tag_id" do

  end

  put "/users/:user_id/projects/:project_id/tasks/:task_id" do

  end

  put "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/" <<
    ":time_entry_id" do

  end
end