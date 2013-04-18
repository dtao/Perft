Perft::App.controllers :projects do
  get "/:id" do |id|
    @project = Project.get(id.to_i)
    render :"projects/show"
  end

  post "/create" do
    project = Project.create(:name => params[:name])
    flash[:notice] = "Created project '#{project.name}'"
    redirect("/")
  end
end
