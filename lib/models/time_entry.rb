class TimeEntry
  include DataMapper::Resource
  
  property :id, Serial
  property :start_time, Time, :required => true
  property :end_time, Time, :required => true
  property :type, Enum[:manual, :timed], :required => true, :default => :timed
  property :created_on, Time, :required => true, :default => Time.now,
    :writer => :private

  belongs_to :task
end