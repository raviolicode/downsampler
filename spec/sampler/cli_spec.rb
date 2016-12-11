require 'spec_helper'

RSpec.describe SamplerCli, type: :aruba, cli: true do
  context "when using arguments" do
    it 'fails with no arguments' do
      run_command('sampler')

      expect(last_command_started.output).to start_with  "No value provided for required arguments 'input_file', 'output_file'"
    end

    it 'fails with one argument' do
      run_command("sampler #{input_path}")

      expect(last_command_started.output).to start_with  "No value provided for required arguments 'output_file'"
    end

    it 'succeeds with two arguments' do
      run_command("sampler #{input_path} #{output_path}")

      expect(last_command_started).to be_successfully_executed
    end
  end

  context "when using options" do
    it 'requires --samples value' do
      run_command("sampler #{input_path} #{output_path} --samples")

      expect(last_command_started.output).to start_with  "No value provided for option '--samples'"
    end

    it 'requires --samples value to be a number' do
      run_command("sampler #{input_path} #{output_path} --samples not_a_number")

      expect(last_command_started.output).to start_with 'Expected numeric value for \'--samples\'; got "not_a_number"'
    end

    Strategy.available_strategies.each do |strategy|
      it "accepts --sample value to be #{strategy}" do
        run_command("sampler #{input_path} #{output_path} --sample_by #{strategy}")

        expect(last_command_started).to be_successfully_executed
      end
    end

    it "doesn't accept a non-valid sampling strategy" do
      valid_strategies = Strategy.available_strategies.join(", ")
      run_command("sampler #{input_path} #{output_path} --sample_by invalid_strategy")

      expect(last_command_started.output).to start_with "Expected '--sample-by' to be one of #{valid_strategies}; got invalid_strategy"
    end
  end

  context "when calling the sampler" do
    it "processes successfully a file with 2 samples" do
      run_command("sampler #{input_path} #{output_path} --sample_by peak --samples 2")
      expected_output = [2.0, 4.0].join("\n")

      expect(output_path).to have_content(expected_output)
    end
  end

  # Helper methods
  def input_path
    @input_path ||= File.expand_path('spec/fixtures/sample.csv')
  end

  def output_path
    @output_path ||= File.expand_path('tmp/output.csv')
  end
end
