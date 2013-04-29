source "https://rubygems.org"

# Server requirements
gem "thin"

# Optional JSON codec (faster performance)
# gem "oj"

# Project requirements
gem "foreman"
gem "rake"

# DB requirements
[
  "dm-sqlite-adapter",
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

# Component requirements
gem "json"
gem "sass"
gem "haml"
gem "randy"
gem "dm-noisy-failures"
gem "omniauth"
gem "omniauth-github"

# Test requirements

# Padrino Stable Gem
gem "padrino", "0.11.1"
