class Machine
  include DataMapper::Resource

  belongs_to :user
  has n, :performance_test_suite_runs

  property :id,          Serial
  property :user_id,     Integer, :index => true, :required => true
  property :name,        String,  :required => true
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
