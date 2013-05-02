source "https://rubygems.org"

# Server requirements
gem "thin"

# Optional JSON codec (faster performance)
# gem "oj"

# Project requirements
gem "foreman"
gem "rake"

# Component requirements
gem "json"
gem "sass"
gem "haml"
gem "randy"
# gem "dm-noisy-failures"
gem "omniauth"
gem "omniauth-github"

# The latest DataMapper branch has some fixes for Ruby 2.0
[
  "dm-validations",
  "dm-timestamps",
  "dm-migrations",
  "dm-constraints",
  "dm-aggregates",
  "dm-types",
  "dm-core",
  "dm-transactions"
].each do |data_mapper_gem|
  gem data_mapper_gem, :git => "git://github.com/datamapper/#{data_mapper_gem}.git", :branch => "release-1.2"
end

# Environment-specific requirements
group :production do
  gem "dm-postgres-adapter"
  gem "pg"
end

group :development do
  gem "dm-sqlite-adapter"
end

# Padrino Stable Gem
gem "padrino", "0.11.1"
