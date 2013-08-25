describe Atta::Api do
  context "/users/:user_id/projects" do
    it "returns all the projects the specified user contributes to" do
      user = Fabricate(:user)
      projects = [
        Fabricate(:project, users: [user]), 
        Fabricate(:project, users: [user])
      ]
      get "/users/#{user.id}/projects"
      last_response.body.should eql projects.to_json
    end
  end

  context "/users/:user_id/projects/:project_id" do
    it "returns the user's project matching the specified project id" do
      project = Fabricate(:project_with_five_users)
      get "/users/#{project.users.first.id}/projects/#{project.id}"
      last_response.body.should eql project.to_json
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
      user = Fabricate(:user)
      project = Fabricate(:project_with_tags, users: [user])
      get "/users/#{user.id}/projects/#{project.id}/tags"
      last_response.body.should eql project.tags.to_json
    end
  end
  
  context "/users/:user_id/projects" do
    it "creates and returns the project for the specified user" do
      user = Fabricate(:user)
      post "/users/#{user.id}/projects", 
           Fabricate.build(:project, name: "POST project").attributes
      last_response.body.should eql user.projects.last.to_json
    end
  end

  context "/users/:user_id/projects/:project_id/contributors" do
    it "adds an existing user as a contributor to the specified project" do
      user = Fabricate(:user)
      project = Fabricate(:project, users: [user])
      post "/users/#{user.id}/projects/#{project.id}/contributors",
           user.attributes
      last_response.body.should eql user.to_json
      project.reload
      project.users.include?(user).should eql true
    end
  end

  context "/users/:user_id/projects/:project_id/tags" do
    it "adds an existing tag to the specified project" do
      tag = Fabricate(:tag)
      project = Fabricate(:project)
      post "/users/#{project.users.first.id}/projects/#{project.id}/tags",
           tag.attributes
      last_response.body.should eql tag.to_json
      project.reload
      project.tags.include?(tag).should eql true
    end
  end

  context "/users/:user_id/projects/:project_id" do
    it "returns the updated project" do
      name = "an updated name"
      description = "an updated description"
      project = Fabricate(:project_with_five_users)
      put "/users/#{project.users.first.id}/projects/#{project.id}",
          :name => name,
          :description => description
      project.reload
      last_response.body.should eql project.to_json
      project.name.should eql name
      project.description.should eql description
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
end