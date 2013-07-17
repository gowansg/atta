class Nonce
  include DataMapper::Resource
  property :id, Serial
  property :value, String, :length => 5..15, :required => true
  property :last_used, Time, :required => true
end