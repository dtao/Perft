class PerformanceTestSuite
  include DataMapper::Resource

  belongs_to :project
  has n, :performance_tests
  has n, :performance_test_suite_runs

  property :id,         Serial
  property :project_id, Integer
  property :name,       String
  property :created_at, DateTime
  property :updated_at, DateTime

  def process_client_results(results, machine)
    self.transaction do
      test_suite_run = self.performance_test_suite_runs.create(:machine => machine)
      results.each do |result|
        test = self.performance_tests.first_or_create(:name => result["description"])
        test.performance_test_runs.create({
          :performance_test_suite_run => test_suite_run,
          :elapsed_seconds => result["elapsed_seconds"].to_f
        })
      end
    end
  end
end
