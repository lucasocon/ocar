# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ocar/version'

Gem::Specification.new do |spec|
  spec.name          = "ocar"
  spec.version       = Ocar::VERSION
  spec.authors       = ["Lucas Ocon"]
  spec.email         = ["lucas_masterclas@hotmail.com"]

  spec.summary       = %q{A minimal gem to get the package information on the OCA service (Argentinian Courrier)}
  spec.description   = %q{This gem permit you follow your package or another(if you have the trackID on the OCA courries service (Argentinian Courrier)}
  spec.homepage      = "https://github.com/lucasocon/ocar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "typhoeus"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
