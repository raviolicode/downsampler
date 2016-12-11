class Strategy
  STRATEGIES = [:peak, :sum]

  def self.peak(samples)
    samples.max.to_f.round(1)
  end

  def self.sum(samples)
    samples.inject(0, :+).to_f.round(1)
  end

  def self.available_strategies
    STRATEGIES.map(&:to_s)
  end
end