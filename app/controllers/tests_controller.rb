Perft::App.controllers :tests do
  get "/:id" do |id|
    @test = PerformanceTest.get(id.to_i)
    test_runs = @test.runs(:order => [:id.desc])

    # Hack alert! Don't show the 'HEAD' run if it isn't the most recent.
    test_runs.reject!(&:wip?) unless test_runs.first.try(:wip?)

    @tags = test_runs.map(&:tags_key).uniq.sort
    @test_runs = test_runs.group_by(&:changeset)

    @latest_run = @test.suite.runs.latest
    render :"tests/show"
  end

  post "/compare" do
    @tests = PerformanceTest.all(:id => params["include"].map(&:to_i))
    @suite = @tests.first.suite
    render :"tests/compare"
  end
end
