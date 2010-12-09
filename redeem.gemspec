require File.expand_path("../lib/redeem/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "redeem"
  s.version     = Redeem::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Grzegorz Kazulak", "Adam Lipka"]
  s.email       = ["grzegorz.kazulak@gmail.com", "adam.lipka@polcode.com"]
  s.homepage    = "http://github.com/alluniq/redeem"
  s.summary     = "Redemption functionality for your Rails 3.0 application."
  s.description = "Redemption functionality for your Rails 3.0 application"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "activemodel", "~> 3.0.0"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", "~> 2.0.0"

  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
end