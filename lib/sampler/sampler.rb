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
    CSV.open(@output, 'w') do |csv|
      sample_source = []
      line = 0
      CSV.foreach(@input, converters: :numeric) do |row|
        check_valid_line(row)
        sample_source << row[0]
        if( sample_source_complete?(line) )
          csv << [Strategy.send(@strategy, sample_source)]
          sample_source = []
        end
        line += 1
      end
    end
  end

  private
  # Count the number of lines using Unix.
  # I'm not opening the file this way
  def total_lines
    @total_lines ||= %x{wc -l #{@input}}.split.first.to_i + 1
  end

  def sample_size
    @sample_size ||= total_lines / samples
  end

  def sample_source_complete?(line)
    (line % sample_size) == (sample_size - 1)
  end

  def check_valid_source
    if((total_lines % samples) != 0)
      raise ArgumentError.new("Source file is invalid, total lines (#{total_lines}) should be multiple of #{samples}.") 
    end
  end

  def check_valid_line(row)
    raise ArgumentError.new("Input file contains a non-numeric value.") unless row[0].is_a? Numeric 
  end
end