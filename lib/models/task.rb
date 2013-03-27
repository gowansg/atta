require "data_mapper"
require_relative "time_entry"

class Task
  include DataMapper::Resource 

  property :id, Serial
  property :name, String, :length => 0..50
  property :description, String, :length => 0..500
  property :project_id, Integer, :required => true
  
  belongs_to :project
  has n, :time_entries
end