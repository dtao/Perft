class PerformanceTest
  include DataMapper::Resource
  include Taggable

  belongs_to :suite, "PerformanceTestSuite"
  has n, :runs, "PerformanceTestRun", :child_key => [:test_id]

  property :id,         Serial
  property :suite_id,   Integer, :required => true
  property :name,       String,  :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end
