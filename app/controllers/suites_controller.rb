Perft::App.controllers :suites do
  get "/:id" do |id|
    @suite = PerformanceTestSuite.get(id.to_i)
    @suite_runs = @suite.performance_test_suite_runs(:order => [:id.desc])

    # Hack alert! Don't show the 'HEAD' run if it isn't the most recent.
    @suite_runs.reject!(&:wip?) unless @suite_runs.first.try(:wip?)

    render :"suites/show"
  end

  get "/:suite_id/:run_id" do |suite_id, run_id|
    @suite = PerformanceTestSuite.get(suite_id.to_i)
    @suite_run = run_id == "latest" ?
      @suite.performance_test_suite_runs.first(:order => [:id.desc]) :
      @suite.performance_test_suite_runs.get(run_id.to_i)
    render :"suites/run"
  end
end
