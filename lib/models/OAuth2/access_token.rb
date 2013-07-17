class AccessToken
  include DataMapper::Resource

  property :id, Serial
  property :value, String, :length => 15, :required => true
  property :secret, String, :length => 256, :required => true
  property :created_on, Time, :required => true, :default => Time.now,
    :writer => :private

  belongs_to :client
  belongs_to :user
end