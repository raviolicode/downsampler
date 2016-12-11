require 'spec_helper'
require 'fileutils'

RSpec.describe Sampler do
  Strategy.available_strategies.each do |strategy|
    it "should sample by strategy #{strategy}" do
      input, output = prepare_test_files('spec/fixtures/sample.csv', 'tmp/output.csv')
      expected_output = File.read(File.expand_path("spec/fixtures/#{strategy}.csv"))
      Sampler.new(input, output, {samples: 2, sample_by: strategy}).process! 

      expect(output).to have_content(expected_output)
    end
  end

  it "should sample using 2 samples" do
    input, output = prepare_test_files('spec/fixtures/sample.csv', 'tmp/output.csv')
    expected_output = [2.0, 4.0].join("\n")
    Sampler.new(input, output, {samples: 2, sample_by: :peak}).process!

    expect(output).to have_content(expected_output)
  end

  it "should return all the lines when samples parameter is not given" do
    input, output = prepare_test_files('spec/fixtures/sample.csv', 'tmp/output.csv')
    expected_output = [1.0, 2.0, 3.0, 4.0].join("\n")
    Sampler.new(input, output, {sample_by: :peak}).process!

    expect(output).to have_content(expected_output)
  end

  it "total lines should be multiple of samples" do
    input, output = prepare_test_files('spec/fixtures/invalid_sample.csv', 'tmp/output.csv')
    expect{ Sampler.new(input, output, {samples: 2}).process! }.to raise_error(ArgumentError, 
      "Source file is invalid, total lines (3) should be multiple of 2.")
  end

  it "other data types should not be accepted in lines" do
    input, output = prepare_test_files('spec/fixtures/invalid_data_source.csv', 'tmp/output.csv')
    
    expect{ Sampler.new(input, output, {samples: 2}).process! }.to raise_error(ArgumentError,
      "Input file contains a non-numeric value.")
  end

  it "should accept OSX-9 endings" do
    values = generate_r_endings
    input = File.expand_path('tmp/input.csv')
    expected_output = values.join("\n")
    File.write(input, values.join("\r"))
    input, output = prepare_test_files(input, 'tmp/output.csv')

    Sampler.new(input, output, {sample_by: :peak}).process!
    expect(output).to have_content(expected_output)
  end

  def generate_r_endings
    (365).times.map do
      (rand * 100.0).round(1).to_s
    end
  end
end
