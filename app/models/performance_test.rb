class PerformanceTest
  include DataMapper::Resource

  belongs_to :suite, "PerformanceTestSuite"
  has n, :runs, "PerformanceTestRun"

  property :id,         Serial
  property :suite_id,   Integer, :required => true
  property :name,       String,  :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end
