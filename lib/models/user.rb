class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String, :length => 1..50, :required => true
  property :active, Boolean, :default => true
  property :email, String, :length => 5..75, :required => true

  has n, :projects, :through => Resource
end