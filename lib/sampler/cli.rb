require 'thor'

class SamplerCli < Thor::Group
  desc "Usage: sampling INPUT_FILE OUTPUT_FILE [--samples NUMBER]"

  argument :input_file, type: :string
  argument :output_file, type: :string
  class_option :samples, type: :numeric, desc: 'desired NUMBER of data-points to be in the output file'
  class_option :sample_by, enum: Strategy.available_strategies, default: :peak, desc: 'strategy on how data is downsampled'
  def sampling
    Sampler.new(input_file, output_file, options).process!
  end
end
