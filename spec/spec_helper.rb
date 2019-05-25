# frozen_string_literal: true

require "simplecov"
require "coveralls"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter,
])

SimpleCov.start { add_filter "spec" }

require "bundler/setup"
require "telegraf_agent"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.order = :random
  Kernel.srand config.seed
  config.disable_monkey_patching!
  config.expect_with(:rspec) { |c| c.syntax = :expect }
end
