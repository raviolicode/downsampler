# Coveralls
require 'coveralls'
Coveralls.wear!

# Aruba
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
::Dir.glob(::File.expand_path('../support/**/*.rb', __FILE__)).each { |f| require_relative f }

require_relative '../lib/sampler.rb'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # config.filter_run :focus
  # config.run_all_when_everything_filtered = true
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 3
  config.order = :random
  Kernel.srand config.seed
end

RSpec::Matchers.define :have_content do |expected|
  match do |actual|
    @actual = File.read(actual).chomp
    values_match? expected, @actual
  end
  diffable
end

RSpec::Matchers.define :have_same_content_as do |expected|
  match do |actual|
    @actual = File.read(actual).chomp
    @expected = File.read(expected).chomp
    values_match? @expected, @actual
  end
  diffable
end

def run_command(command)
  run(command)
  stop_all_commands
end

def prepare_test_files(input_name, output_name)
  input = File.expand_path(input_name)
  output = File.expand_path(output_name)
  FileUtils.rm(output, force: true)
  FileUtils.touch(output)
  [input, output]
end
