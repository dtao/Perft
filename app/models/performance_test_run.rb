class PerformanceTestRun
  include DataMapper::Resource
  include Taggable

  belongs_to :test, "PerformanceTest"
  belongs_to :suite_run, "PerformanceTestSuiteRun"
  has 1, :suite, "PerformanceTestSuite", :through => :test

  property :id,              Serial
  property :test_id,         Integer, :required => true
  property :suite_run_id,    Integer, :required => true
  property :elapsed_seconds, Float,   :required => true
  property :repetitions,     Integer, :required => true, :default => 1
  property :created_at,      DateTime
  property :updated_at,      DateTime

  def wip?
    self.suite_run.changeset.blank?
  end

  def average
    self.elapsed_seconds / self.repetitions
  end
end
