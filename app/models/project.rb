class Project
  include DataMapper::Resource

  has n, :performance_test_suites
  has n, :performance_test_suite_runs, :through => :performance_test_suites

  property :id,         Serial
  property :name,       String, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end
