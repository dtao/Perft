class PerformanceTestSuite
  include DataMapper::Resource

  belongs_to :project
  has n, :performance_tests
  has n, :performance_test_suite_runs

  property :id,         Serial
  property :project_id, Integer, :required => true
  property :name,       String,  :required => true
  property :created_at, DateTime
  property :updated_at, DateTime

  def process_client_results(changeset, results, machine, comment)
    self.transaction do
      test_suite_run = self.performance_test_suite_runs.first({
        :machine   => machine,
        :changeset => changeset
      })

      if test_suite_run.present?
        test_suite_run.performance_test_runs.destroy
        test_suite_run.destroy
      end

      test_suite_run = self.performance_test_suite_runs.create({
        :machine   => machine,
        :changeset => changeset,
        :comment   => comment
      })

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
