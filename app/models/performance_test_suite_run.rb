class PerformanceTestSuiteRun
  include DataMapper::Resource

  belongs_to :machine
  belongs_to :suite, "PerformanceTestSuite"
  has n, :test_runs, "PerformanceTestRun", :child_key => [:suite_run_id]

  property :id,         Serial
  property :machine_id, Integer, :required => true
  property :suite_id,   Integer, :required => true
  property :changeset,  String,  :index => true
  property :comment,    String
  property :changes,    Text
  property :created_at, DateTime
  property :updated_at, DateTime

  def self.latest
    first(:order => [:id.desc])
  end

  def total_elapsed_seconds
    self.test_runs.sum(:elapsed_seconds)
  end

  def wip?
    self.changeset.blank?
  end
end
