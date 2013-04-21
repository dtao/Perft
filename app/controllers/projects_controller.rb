Perft::App.controllers :projects do
  get "/:id" do |id|
    @project = Project.get(id.to_i)
    render :"projects/show"
  end

  post "/create" do
    project = Project.create(:name => params["name"])
    flash[:notice] = "Created project '#{project.name}'"
    redirect("/")
  end

  post "/:id/:test_suite_name" do |id, test_suite_name|
    auth = Rack::Auth::Basic::Request.new(request.env)
    raise "Not authorized - no credentials provided." unless auth.provided? && auth.basic? && auth.credentials

    machine_id, api_key = auth.credentials
    machine = Machine.get(machine_id.to_i)
    raise "Not authorized - invalid credentials." if machine.nil? || api_key != machine.api_key

    project    = Project.get(id.to_i)
    test_suite = project.performance_test_suites.first_or_create(:name => CGI.unescape(test_suite_name))
    test_suite.process_client_results(params["results"], machine, params["comment"])
  end
end
