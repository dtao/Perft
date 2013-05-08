Perft::App.controllers :suites do
  get "/versions/:id" do |id|
    @suite = PerformanceTestSuite.get(id.to_i)
    @suite_runs = @suite.runs(:order => [:id.desc]).group_consecutive(&:version)
    render :"suites/versions"
  end

  get "/major/:id" do |id|
    @suite = PerformanceTestSuite.get(id.to_i)
    runs_array = @suite.runs(:order => [:id.desc]).to_a
    @suite_runs = runs_array.each_with_index.top(10) do |run, i|
      i == 0 ? 0 : (run.total_elapsed_seconds - runs_array[i - 1].total_elapsed_seconds).abs
    end.map(&:first).sort_by(&:id).reverse
    render :"suites/show"
  end

  get "/:id" do |id|
    @suite = PerformanceTestSuite.get(id.to_i)
    @suite_runs = @suite.runs(:order => [:id.desc])

    # Hack alert! Don't show the 'HEAD' run if it isn't the most recent.
    @suite_runs.reject!(&:wip?) unless @suite_runs.first.try(:wip?)

    render :"suites/show"
  end

  get "/:suite_id/:run_id" do |suite_id, run_id|
    @suite = PerformanceTestSuite.get(suite_id.to_i)
    @suite_run = run_id == "latest" ?
      @suite.runs.first(:order => [:id.desc]) :
      @suite.runs.get(run_id.to_i)
    @test_runs = @suite_run.test_runs.sort { |x, y| y.average <=> x.average }
    render :"suites/run"
  end
end
