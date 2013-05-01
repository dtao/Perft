class Tag
  include DataMapper::Resource

  has n, :projects, :through => Resource
  has n, :performance_tests, :through => Resource
  has n, :performance_test_runs, :through => Resource

  property :id,   Serial
  property :name, String, :unique_index => true
end
