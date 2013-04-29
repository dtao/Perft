Perft::App.controllers :machines do
  get "/:id" do |id|
    @machine = Machine.get(id.to_i)
    render :"machines/show"
  end

  post "/create" do
    machine = current_user.machines.create({
      :name => params["name"],
      :description => params["description"]
    })
    flash[:notice] = "Created machine '#{machine.name}'"
    redirect("/")
  end
end
