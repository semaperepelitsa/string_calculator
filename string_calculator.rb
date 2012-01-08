module StringCalculator
  class << self
    def add(input)
      numbers = input.scan(/-?\d+/).map(&:to_i).reject{ |n| n > 1000 }

      negatives = numbers.select{ |n| n < 0 }
      if negatives.any?
        raise ArgumentError, "input has negative numbers: #{negatives.join(", ")}"
      end

      numbers.inject(:+) || 0
    end
  end
end
