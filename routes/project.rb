class Atta::Api < Sinatra::Base
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
  
  put "/users/:user_id/projects/:project_id" do
    project = Project.get(params[:project_id])
    project.update(:name => params[:name] || project.name,
                   :description => params[:description] || project.description,
                   :deleted => params[:deleted] || project.deleted)
    project.to_json if project.valid?
  end
end