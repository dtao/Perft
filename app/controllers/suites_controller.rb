Perft::App.controllers :suites do
  get "/:id" do |id|
    @suite = PerformanceTestSuite.get(id.to_i)
    @tests = @suite.performance_tests
    render :"suites/show"
  end
end
