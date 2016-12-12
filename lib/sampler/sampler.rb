require 'csv'

class Sampler
  attr_reader :input
  attr_reader :output
  attr_reader :strategy
  attr_reader :samples

  def initialize(input, output, args)
    @input = input
    @output = output
    @samples = args[:samples] || total_lines
    @strategy = (args[:sample_by] || :peak).to_sym
  end

  def process!
    check_valid_source
    File.write(@output, obtain_samples)
  end

  private

  def obtain_samples 
    sample_source = []

    "".tap do |output|
      CSV.foreach(@input, converters: :numeric) do |row|
        sample_source << get_value(row)
        if(sample_source.count == sample_size)
          output << "#{Strategy.send(@strategy, sample_source)}\n"
          sample_source = []
        end
      end
    end
  end

  # Count the number of lines using Unix.
  # I'm not opening the file this way
  def total_lines
    @total_lines ||= %x{wc -l #{@input}}.split.first.to_i + 1
  end

  def sample_size
    @sample_size ||= total_lines / samples
  end

  def check_valid_source
    if((total_lines % samples) != 0)
      raise ArgumentError.new("Source file is invalid, total lines (#{total_lines}) should be multiple of #{samples}.") 
    end
  end

  def get_value(row)
    raise ArgumentError.new("Input file contains a non-numeric value.") unless row[0].is_a? Numeric 
    row[0]
  end
end