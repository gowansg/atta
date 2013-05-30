class Tag 
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 1..25, :required => true
  has n, :tasks, :through => Resource
  has n, :projects, :through => Resource
end