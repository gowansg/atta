require 'data_mapper'

class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String, :length => 1..50, :allow_blank => false
  property :active, Boolean, :default => true

  has n, :projects, :through => Resource
end