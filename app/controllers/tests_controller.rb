Perft::App.controllers :tests do
  get "/:id/:suite_run_id" do |id, suite_run_id|
    @test = PerformanceTest.get(id.to_i)
    test_runs = @test.runs(:order => [:id.desc])

    # Hack alert! Don't show the 'HEAD' run if it isn't the most recent.
    test_runs.reject!(&:wip?) unless test_runs.first.try(:wip?)

    @tags = test_runs.map(&:tags_key).uniq.sort
    test_runs_by_changeset = test_runs.group_consecutive(&:suite_run)
    @test_runs = test_runs_by_changeset.map do |suite_run, test_runs|
      [suite_run, test_runs.map_to_hash(&:tags_key)]
    end

    @suite_run = @test.suite.runs.get(suite_run_id.to_i)
    @current_index = @test_runs.map(&:first).take(10).reverse.index(@suite_run) || -1
    render :"tests/show"
  end
end
