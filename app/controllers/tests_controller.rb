Perft::App.controllers :tests do
  get "/:id" do |id|
    @test = PerformanceTest.get(id.to_i)
    render :"tests/show"
  end
end
