# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kinu/version'

Gem::Specification.new do |spec|
  spec.name          = "kinu"
  spec.version       = Kinu::VERSION
  spec.authors       = ["Takatoshi Maeda"]
  spec.email         = ["me@tmd.tw"]

  spec.summary       = %q{image server kinu ruby client}
  spec.description   = %q{image server kinu ruby client}
  spec.homepage      = "https://github.com/TakatoshiMaeda/kinu-ruby"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org/"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "webmock", "~> 2.3"
end
