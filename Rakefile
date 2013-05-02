require 'bundler/setup'
require 'padrino-core/cli/rake'
require 'rspec/core/rake_task'

PadrinoTasks.use(:database)
PadrinoTasks.use(:datamapper)
PadrinoTasks.init

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = "--format=n --color"
end
