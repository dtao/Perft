class Identity
  include DataMapper::Resource

  belongs_to :user

  property :id,       Serial
  property :user_id,  Integer, :index => true
  property :provider, String,  :unique_index => :provider_uid
  property :uid,      String,  :unique_index => :provider_uid
  property :name,     String
  property :email,    String,  :index => true
end
