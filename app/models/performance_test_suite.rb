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
    version   = data["version"]
    comment   = data["comment"]
    changes   = data["changes"]
    append    = data["append"]

    self.transaction do
      suite_run = self.runs.first({
        :machine   => machine,
        :changeset => changeset
      })

      if suite_run.present? && !append
        suite_run.test_runs.destroy!
        suite_run.destroy
        suite_run = nil
      end

      suite_run ||= self.runs.create({
        :machine   => machine,
        :changeset => changeset,
        :version   => version,
        :comment   => comment,
        :changes   => changes
      })

      results.each do |result|
        test = self.tests.first_or_create(:name => result["description"])
        test_run = test.runs.create({
          :suite_run => suite_run,
          :repetitions => result["repetitions"].to_i,
          :elapsed_seconds => result["elapsed_seconds"].to_f
        })
        test_run.add_tags(result["tags"])
      end
    end
  end
end
