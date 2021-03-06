# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'replicon_scheduler_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'replicon_scheduler_client'
  spec.version       = RepliconSchedulerClient::VERSION
  spec.authors       = ['darren.oleary']
  spec.email         = ['darren.oleary@solium.com']

  spec.summary       = 'RepliconScheduler REST API Client'
  spec.description   = 'RepliconScheduler REST API Client'
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://github.com/daroleary/replicon_scheduler_client'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '4.2.5'
  spec.add_dependency 'rest-client', '~> 1.8.0'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'byebug', '~> 8.2.2'
  spec.add_development_dependency 'factory_girl_rails'
  spec.add_development_dependency 'faker', '~> 1.6.1'
end
