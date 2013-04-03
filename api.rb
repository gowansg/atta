require 'sinatra'
require 'openid'

class Api < Sinatra::Base

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

  end

  get '/tags/:tag_id' do

  end
  
  get '/users/:user_id' do

  end

  get '/users/:user_id/projects' do

  end

  get '/users/:user_id/projects/:project_id' do

  end

  get '/users/:user_id/projects/:project_id/contributors' do

  end

  get '/users/:user_id/projects/:project_id/tags' do

  end

  get '/users/:user_id/projects/:project_id/tasks' do

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