class Strategy
  STRATEGIES = [:peak, :sum]

  class << self
    def peak(samples)
      samples.max.to_f.round(1)
    end

    def sum(samples)
      samples.inject(0, :+).to_f.round(1)
    end

    def available_strategies
      STRATEGIES.map(&:to_s)
    end
  end
end