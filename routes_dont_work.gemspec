$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'routes_dont_work/version'

Gem::Specification.new do |s|
  s.name        = "routes_dont_work"
  s.version     = RoutesDontWork::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.authors     = ["Jason Barnabe"]
  s.email       = "jason.barnabe@canadadrugs.com"
  s.homepage    = "https://github.com/canadadrugs/routes_dont_work"
  s.summary     = "routes_dont_work-#{RoutesDontWork::Version::STRING}"
  s.description = "Provide a test to check if all the routes in a Rails app go to a controller or view"

  s.files             = `git ls-files -- lib/*`.split("\n")
  s.files            += %w[README.md]
  s.test_files        = `git ls-files -- {spec}/*`.split("\n")
  s.rdoc_options      = ["--charset=UTF-8"]
  s.require_path      = "lib"

  s.add_runtime_dependency(%q<actionpack>, [">= 4.0"])
  s.add_runtime_dependency(%q<railties>, [">= 4.0"])

  s.add_development_dependency(%q<rspec>, [">= 3.0"])
  s.add_development_dependency(%q<byebug>)
  s.add_development_dependency(%q<rspec-rails>)
end