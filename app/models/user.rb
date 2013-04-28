class User
  include DataMapper::Resource

  has n, :identities
  has 1, :primary_identity, "Identity"

  property :id,                  Serial
  property :primary_identity_id, Integer, :required => true

  def self.get_or_create(provider, uid, user_info)
    attributes = { :provider => provider, :uid => uid }
    identity   = Identity.first(attributes) || Identity.new(attributes)

    identity.name  = user_info["name"]
    identity.email = user_info["email"]

    if identity.new? || identity.dirty?
      # This should be the only place where an Identity may potentially have no
      # user ID.
      identity.save
    end

    if identity.user.nil?
      identity.update(:user => User.create(:primary_identity_id => identity.id))
    end

    identity.user
  end

  def name
    self.primary_identity.name
  end

  def email
    self.primary_identity.email
  end
end
