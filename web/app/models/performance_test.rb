class PerformanceTest
  include DataMapper::Resource

  belongs_to :performance_test_suite
  has n, :performance_test_runs

  property :id,                        Serial
  property :performance_test_suite_id, Integer
  property :name,                      String
  property :created_at,                DateTime
  property :updated_at,                DateTime
end
