class PerformanceTestSuiteRun
  include DataMapper::Resource

  belongs_to :machine
  belongs_to :performance_test_suite
  has n, :performance_test_runs

  property :id,                        Serial
  property :machine_id,                Integer, :required => true
  property :performance_test_suite_id, Integer, :required => true
  property :changeset,                 String,  :index => true
  property :comment,                   String
  property :created_at,                DateTime
  property :updated_at,                DateTime

  def total_elapsed_seconds
    self.performance_test_runs.sum(:elapsed_seconds)
  end

  def wip?
    self.changeset.nil?
  end
end
