require "securerandom"

class AuthorizationCode
  include DataMapper::Resource

  property :value, 
           String, 
           key: true,
           length: 40, 
           default: SecureRandom.urlsafe_base64(30)
  
  property :created_on, Time, required: true, default: Time.now
  property :redeemed_on, Time
  property :redeemed, Boolean, default: false

  belongs_to :client
end