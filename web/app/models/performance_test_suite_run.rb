class PerformanceTestSuiteRun
  include DataMapper::Resource

  belongs_to :machine
  belongs_to :performance_test_suite
  has n, :performance_test_runs

  property :id,                        Serial
  property :machine_id,                Integer
  property :performance_test_suite_id, Integer
  property :created_at,                DateTime
  property :updated_at,                DateTime
end
