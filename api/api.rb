require 'sinatra'
require 'openid'
require 'json'

class API < Sinatra::Base

  # All DELETE requests
  delete '/tags/:tag_id' do

  end

  delete '/users/:user_id' do

  end

  delete '/users/:user_id/projects/:project_id' do

  end

  delete '/users/:user_id/projects/:project_id/contributors/:contributor_id' do

  end

  delete '/users/:user_id/projects/:project_id/tags/:tag_id' do

  end

  delete '/users/:user_id/projects/:project_id/tasks/:task_id/' do

  end

  delete '/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/' << 
    ':time_entry_id' do

  end

  #All GET requests
  get '/' do

  end
  
  get '/tags' do
    Tag.all.to_json
  end

  get '/tags/:tag_id' do
    Tag.get(params[:tag_id]).to_json
  end
  
  get '/users/:user_id' do
    User.get(params[:user_id]).to_json
  end

  get '/users/:user_id/projects' do
    User.get(params[:user_id]).projects.to_json
  end

  get '/users/:user_id/projects/:project_id' do
    Project.first(:id => params[:project_id],
      :users => { :id => params[:user_id] })
      .to_json  
  end

  get '/users/:user_id/projects/:project_id/contributors' do
    User.first(:id => params[:user_id])
      .projects
      .first(:id => params[:project_id])
      .users
      .to_json
  end

  get '/users/:user_id/projects/:project_id/tags' do
    User.first(:id => params[:user_id])
      .projects
      .first(:id => params[:project_id])
      .tasks
      .select { |t| t.tags }
      .to_json
  end

  get '/users/:user_id/projects/:project_id/tasks' do
    User.first(:id => params[:user_id])
      .projects
      .first(:id => params[:project_id])
      .tasks
      .to_json
  end

  get '/users/:user_id/projects/:project_id/tasks/:task_id' do

  end

  get '/users/:user_id/projects/:project_id/tasks/:task_id/time_entries' do

  end

  get '/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/' <<
    ':time_entry_id' do

  end

  #All POST requests
  post '/tags' do

  end

  post '/users' do

  end

  post '/users/:user_id/projects' do

  end

  post '/users/:user_id/projects/:project_id/contributors' do
  
  end

  post '/users/:user_id/projects/:project_id/tags' do

  end

  post '/users/:user_id/projects/:project_id/tasks' do

  end

  post '/users/:user_id/projects/:project_id/tasks/:task_id/time_entries' do

  end

  #All PUT requests
  put '/tags/:tag_id' do

  end

  put '/users/:user_id' do

  end

  put '/users/:user_id/projects/:project_id' do

  end

  put '/users/:user_id/projects/:project_id/contributors/:contributor_id' do

  end
  
  put '/users/:user_id/projects/:project_id/tags/:tag_id' do

  end

  put '/users/:user_id/projects/:project_id/tasks/:task_id' do

  end

  put '/users/:user_id/projects/:project_id/tasks/:task_id/time_entries/' <<
    ':time_entry_id' do

  end
end