class Task
  include DataMapper::Resource 

  property :id, Serial
  property :name, String, :length => 0..50
  property :description, String, :length => 0..500
  
  belongs_to :project
  has n, :time_entries
  has n, :tags, :through => Resource
end