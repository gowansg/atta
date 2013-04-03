require 'data_mapper'

class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String, :length => 1..50, :allow_blank => false
  property :active, Boolean, :default => true

  has n, :projects, :through => Resource

  def create_project(options = {})
    project = Project.create(options)
    project_users.create(:project_id => project.id, :user_id => :id)
    return project
  end

  def delete_project

  end
end