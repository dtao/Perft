class Machine
  include DataMapper::Resource

  property :id,          Serial
  property :name,        String
  property :description, String
  property :api_key,     String
  property :created_at,  DateTime
  property :updated_at,  DateTime

  ALPHANUMERIC = (
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
    "abcdefghijklmnopqrstuvwxyz" +
    "0123456789"
  ).freeze

  before :create do
    self.api_key ||= Randy.string(64, ALPHANUMERIC)
  end
end
