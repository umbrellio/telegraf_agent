# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "telegraf_agent"
  spec.version       = "0.1.0"
  spec.authors       = ["nulldef"]
  spec.email         = ["nulldefiner@gmail.com"]

  spec.summary       = "Telegraf agent"
  spec.description   = "Telegraf agent"
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "influxdb", "~> 0.6"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "coveralls", "~> 0.8"
  spec.add_development_dependency "rake", "~> 11.2"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "simplecov", "~> 0.16"
end