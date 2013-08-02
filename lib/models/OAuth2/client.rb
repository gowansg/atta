class Client
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 2..50, :required => true
  property :email, String, :length => 6..50, :required => true
  property :description, String, :length => 0..100
  
  property :created_on, 
           Time, 
           required: true, 
           default: Time.now, 
           writer: :private
  
  property :active, Boolean, :default => true, :required => true
  property :secret, String
  property :application_key, String
  property :redirect_uri, String
end