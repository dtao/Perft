class PerformanceTestRun
  include DataMapper::Resource

  belongs_to :performance_test
  belongs_to :performance_test_suite_run

  property :id,                            Serial
  property :performance_test_id,           Integer
  property :performance_test_suite_run_id, Integer
  property :elapsed_seconds,               Float
  property :created_at,                    DateTime
  property :updated_at,                    DateTime
end
