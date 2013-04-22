Perft::App.controllers :tests do
  get "/:id" do |id|
    @test = PerformanceTest.get(id.to_i)
    render :"tests/show"
  end

  post "/compare" do
    @tests = PerformanceTest.all(:id => params["include"].map(&:to_i))
    @suite = @tests.first.performance_test_suite
    render :"tests/compare"
  end
end
