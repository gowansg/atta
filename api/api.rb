require "sinatra"
require "sinatra/contrib"
require "openid"
require "json"

class API < Sinatra::Base
  register Sinatra::RespondWith
  #respond_to :json

  before "/users/:user_id/*" do
    resource_owner_id = AccessToken.get(params[:access_token]).user_id
    halt 403 unless params[:user_id] == resource_owner_id
  end

  get "/oauth/authorize" do
    client = Client.first(client_id: params[:client_id])

    haml :authorization_notice if client && 
                                  client.redirect_uri
                                        .casesmp(params[:redirect_uri])
                                        .zero?
    
    haml :invalid_client_notice 
  end

  post "/oauth/authorize" do

  end

  post "/oauth/access_token" do
    code = params[:code]
    grant_type = params[:grant_type]
    client_id = params[:client_id]
    client_secred = params[:client_secred]

    Client.first(secret: params[:client_secred])
  end

  # All DELETE requests
  delete "/tags/:tag_id" do
    tag = Tag.get(params[:tag_id])
    tag.tasks.all.destroy
    tag.destroy.to_json 
  end

  delete "/users/:user_id" do
    user = User.get(params[:user_id])
    user.projects.all.destroy
    user.destroy.to_json
  end

  delete "/users/:user_id/projects/:project_id" do
    project = Project.get(params[:project_id])
    project.tags.all.destroy
    project.tasks.all.destroy
    project.users.all.destroy
    project.destroy.to_json
  end

  delete "/users/:user_id/projects/:project_id/contributors/:contributor_id" do
    ProjectUser.all(:user_id => params[:contributor_id], 
                    :project_id => params[:project_id])
               .destroy
               .to_json
  end

  delete "/users/:user_id/projects/:project_id/tags/:tag_id" do
    ProjectTag.all(:project_id => params[:project_id], 
                   :tag_id => params[:tag_id])
              .destroy
              .to_json
  end

  delete "/users/:user_id/projects/:project_id/tasks/:task_id" do
    task = Task.get(params[:task_id])
    task.tags.all.destroy
    task.time_entries.all.destroy
    task.destroy.to_json
  end

  delete "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/" << 
         ":time_entry_id" do
    time_entry = TimeEntry.get(params[:time_entry_id])
    time_entry.destroy.to_json
  end

  #All GET requests
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
    Project.get(params[:project_id]).tags.to_json
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
    tag = Tag.create(:name => params[:name], :tasks => params[:tasks] || [])
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
    project = Project.get(params[:project_id])
    contributor = User.get(params[:id])
    project.users << contributor
    project.save
    contributor.to_json
  end

  post "/users/:user_id/projects/:project_id/tags" do
    project = Project.get(params[:project_id])
    tag = Tag.get(params[:id])
    project.tags << tag
    project.save
    tag.to_json
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

  put "/users/:user_id/projects/:project_id/tasks/:task_id" do
    task = Task.get(params[:task_id])
    task.update(:name => params[:name] || task.name, 
                :description => params[:description] || task.description)
    task.to_json if task.valid?
  end

  put "/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/" <<
      ":time_entry_id" do
    time_entry = TimeEntry.get(params[:time_entry_id])
    time_entry.update(:end_time => params[:end_time] || time_entry.end_time)
    time_entry.to_json if time_entry.valid?
  end
end