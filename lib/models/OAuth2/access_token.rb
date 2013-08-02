class AccessToken
  include DataMapper::Resource

  property :value, 
           String, 
           key: true, 
           length: 64,
           required: true,
           default: SecureRandom.urlsafe_base64(48)
  
  property :created_on, 
           Time, 
           required: true, 
           default: Time.now, 
           writer: :private

  belongs_to :client
  belongs_to :user
end