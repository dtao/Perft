Perft::App.controllers :tests do
  get "/:id" do |id|
    @test = PerformanceTest.get(id.to_i)
    @test_runs = @test.performance_test_runs(:order => [:id.desc])

    # Hack alert! Don't show the 'HEAD' run if it isn't the most recent.
    @test_runs.reject!(&:wip?) unless @test_runs.first.try(:wip?)

    @latest_run = @test.suite.runs.latest
    render :"tests/show"
  end

  post "/compare" do
    @tests = PerformanceTest.all(:id => params["include"].map(&:to_i))
    @suite = @tests.first.suite
    render :"tests/compare"
  end
end
