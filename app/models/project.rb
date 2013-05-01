class Project
  include DataMapper::Resource
  include Taggable

  belongs_to :user
  has n, :suites, "PerformanceTestSuite"
  has n, :suite_runs, "PerformanceTestSuiteRun", :through => :suites, :via => :runs

  property :id,         Serial
  property :user_id,    Integer, :index => true, :required => true
  property :name,       String,  :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end
