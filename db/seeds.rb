dan = User.get_or_create("github", "123456789", {
  "name" => "Daniel Tao",
  "email" => "daniel.tao@gmail.com"
  })

laptop = dan.machines.create({
  "name" => "Dan's laptop",
  "description" => "Dan's laptop",
  "api_key" => "abcdefghijklmnopqrstuvwxyz0123456789"
  })

safe_yaml = dan.projects.create({
  "name" => "SafeYAML"
  })
