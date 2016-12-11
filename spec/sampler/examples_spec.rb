require 'spec_helper'

RSpec.describe SamplerCli, type: :aruba, examples: true do
  context "one per fifteen minutes" do
    before(:each) do
      @input_path, @output_path = prepare_test_files('spec/fixtures/one-per-fifteen-minutes/source.csv', 'tmp/output.csv')
    end

    it "should output correctly 8760 samples by sum" do
      expected_output = File.read(File.expand_path('spec/fixtures/one-per-fifteen-minutes/output.samples-8760.sum.csv'))
      run_command("sampler #{@input_path} #{@output_path} --sample_by sum --samples 8760")
      expect(@output_path).to have_content(expected_output)
    end

    it "should output correctly 8760 samples by peak" do
      expected_output = File.read(File.expand_path('spec/fixtures/one-per-fifteen-minutes/output.samples-8760.peak.csv'))
      run_command("sampler #{@input_path} #{@output_path} --samples 8760")
      expect(@output_path).to have_content(expected_output)
    end

    it "should output correctly 365 samples by sum" do
      expected_output = File.read(File.expand_path('spec/fixtures/one-per-fifteen-minutes/output.samples-365.sum.csv'))
      run_command("sampler #{@input_path} #{@output_path} --samples 365 --sample_by sum")
      expect(@output_path).to have_content(expected_output)
    end

    it "should output correctly 365 samples by peak" do
      expected_output = File.read(File.expand_path('spec/fixtures/one-per-fifteen-minutes/output.samples-365.peak.csv'))
      run_command("sampler #{@input_path} #{@output_path} --samples 365 --sample_by peak")
      expect(@output_path).to have_content(expected_output)
    end
  end

  context "one per minute" do
    before(:each) do
      @input_path, @output_path = prepare_test_files('spec/fixtures/one-per-minute/source.csv', 'tmp/output.csv')
    end

    it "should output correctly 8760 samples by sum" do
      expected_output = File.read(File.expand_path('spec/fixtures/one-per-minute/output.samples-8760.sample-by-sum.csv'))
      run_command("sampler #{@input_path} #{@output_path} --sample_by sum --samples 8760")
      expect(@output_path).to have_content(expected_output)
    end

    it "should output correctly 8760 samples by peak" do
      expected_output = File.read(File.expand_path('spec/fixtures/one-per-minute/output.samples-8760.sample-by-peak.csv'))
      run_command("sampler #{@input_path} #{@output_path} --sample_by peak --samples 8760")
      expect(@output_path).to have_content(expected_output)
    end

    it "should output correctly 365 samples by sum" do
      expected_output = File.read(File.expand_path('spec/fixtures/one-per-minute/output.samples-365.sample-by-sum.csv'))
      run_command("sampler #{@input_path} #{@output_path} --sample_by sum --samples 365")
      expect(@output_path).to have_content(expected_output)
    end

    it "should output correctly 365 samples by peak" do
      expected_output = File.read(File.expand_path('spec/fixtures/one-per-minute/output.samples-365.sample-by-peak.csv'))
      run_command("sampler #{@input_path} #{@output_path} --sample_by peak --samples 365")
      expect(@output_path).to have_content(expected_output)
    end
  end
end
