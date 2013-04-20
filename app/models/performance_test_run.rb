class PerformanceTestRun
  include DataMapper::Resource

  belongs_to :performance_test
  belongs_to :performance_test_suite_run
  has 1, :performance_test_suite, :through => :performance_test

  property :id,                            Serial
  property :performance_test_id,           Integer, :required => true
  property :performance_test_suite_run_id, Integer, :required => true
  property :elapsed_seconds,               Float,   :required => true
  property :created_at,                    DateTime
  property :updated_at,                    DateTime
end
