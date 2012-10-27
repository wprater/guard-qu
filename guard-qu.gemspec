# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guard/qu/version"

Gem::Specification.new do |s|
  s.name        = "guard-qu"
  s.version     = Guard::QuVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jacques Crocker", "Ryan Long", "David Parry", "Jim Deville", "Will Prater"]
  s.email       = ["railsjedi@gmail.com", 'ryan@rtlong.com', 'james.deville@gmail.com', 'will@superformula.com']
  s.homepage    = 'http://github.com/wprater/guard-qu'
  s.summary     = %q{guard gem for qu}
  s.description = %q{Guard::Qu automatically starts/stops/restarts qu worker}

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project = "guard-qu"

  s.add_dependency 'guard', '>= 1.1'
  s.add_dependency 'qu'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec',         '~> 2.5.0'
  s.add_development_dependency 'guard-rspec',   '>= 0.2.0'
  s.add_development_dependency 'guard-bundler', '>= 0.1.1'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
