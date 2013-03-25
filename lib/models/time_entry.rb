require "data_mapper"
require_relative "task"

class TimeEntry
  include DataMapper::Resource
  
  property :id, Serial
  property :start_time, DateTime
  property :end_time, DateTime
  property :task_id, Integer
  property :discriminator, Integer
  property :creation_time, DateTime

  belongs_to :task
end