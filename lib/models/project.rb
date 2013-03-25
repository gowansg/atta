require "rubygems"
require "data_mapper"
require_relative "task"

class Project
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, String
  property :inception, DateTime
  property :deleted, Boolean

  has n, :tasks
end