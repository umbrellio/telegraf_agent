# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "telegraf_agent/version"

Gem::Specification.new do |spec|
  spec.name     = "telegraf_agent"
  spec.version  = TelegrafAgent::VERSION
  spec.authors  = ["nulldef"]
  spec.email    = ["nulldefiner@gmail.com", "oss@umbrellio.biz"]
  spec.homepage = "https://github.com/umbrellio/telegraf_agent"
  spec.license  = "MIT"

  spec.summary     = "Telegraf agent"
  spec.description = "Telegraf agent"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "influxdb", "~> 0.6"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop-config-umbrellio"
  spec.add_development_dependency "simplecov"
end
