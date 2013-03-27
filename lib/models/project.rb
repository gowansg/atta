require_relative "task"

class Project
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 0..50
  property :description, String, :length => 0..500
  property :created_on, DateTime, :required => true
  property :deleted, Boolean
  property :deleted_on, DateTime

  has n, :tasks
end