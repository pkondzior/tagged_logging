# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tagged_logging/version'

Gem::Specification.new do |gem|
  gem.name          = "tagged_logging"
  gem.version       = Tagged::Logging::VERSION
  gem.authors       = ["Paweł Kondzior"]
  gem.email         = ["pawel@kondzior.com"]
  gem.description   = %q{Wraps any standard Logger object to provide tagging capabilities.}
  gem.summary       = %q{Rails 3.2 TaggedLogging backported to Rails 3.0}
  gem.homepage      = "https://github.com/pkondzior/tagged_logging/"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activesupport", "~> 3.0"
end
