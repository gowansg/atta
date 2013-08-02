class Project
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 0..50
  property :description, String, :length => 0..500
  property :created_on, 
           Time, 
           :required => true, 
           :default => Time.now, 
           :writer => :private

  property :deleted, Boolean, :default => false, :required => true
  property :deleted_on, Time

  has n, :tasks
  has n, :users, :through => Resource
  has n, :tags, :through => Resource
end