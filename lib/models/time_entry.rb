require "data_mapper"
require_relative "task"

class TimeEntry
  include DataMapper::Resource
  
  property :id, Serial
  property :start_time, DateTime, :required => true
  property :end_time, DateTime, :required => true
  property :type, Enum[:manual, :timed], :required => true, :default => :timed
  property :created_on, DateTime, :required => true

  belongs_to :task
end