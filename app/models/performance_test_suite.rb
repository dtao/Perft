class PerformanceTestSuite
  include DataMapper::Resource

  belongs_to :project
  has n, :tests, "PerformanceTest", :child_key => [:suite_id]
  has n, :runs, "PerformanceTestSuiteRun", :child_key => [:suite_id]

  property :id,         Serial
  property :project_id, Integer, :required => true
  property :name,       String,  :required => true
  property :created_at, DateTime
  property :updated_at, DateTime

  def process_client_results(data, machine)
    results   = data["results"]
    changeset = data["changeset"]
    comment   = data["comment"]
    changes   = data["changes"]

    self.transaction do
      suite_run = self.runs.first({
        :machine   => machine,
        :changeset => changeset
      })

      if suite_run.present?
        suite_run.performance_test_runs.destroy!
        suite_run.destroy
      end

      suite_run = self.runs.create({
        :machine   => machine,
        :changeset => changeset,
        :comment   => comment,
        :changes   => changes
      })

      results.each do |result|
        test = self.tests.first_or_create(:name => result["description"])
        test.runs.create({
          :suite_run => suite_run,
          :repetitions => result["repetitions"].to_i,
          :elapsed_seconds => result["elapsed_seconds"].to_f
        })
      end
    end
  end
end
