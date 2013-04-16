class Tag 
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 1..15
end