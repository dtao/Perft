class PerformanceTestSuite
  include DataMapper::Resource

  belongs_to :project
  has n, :performance_tests
  has n, :performance_test_suite_runs

  property :id,         Serial
  property :project_id, Integer
  property :created_at, DateTime
  property :updated_at, DateTime
end
