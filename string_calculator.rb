module StringCalculator
  class << self
    DELIMITER_REGEXP = %r(^//(?:\[(.+)\]|(.))\n)

    def add(delimiter_and_input)
      delimiter, input = extract_delimiter_and_input(delimiter_and_input)

      numbers = input.split(delimiter).map(&:to_i).reject{ |n| n > 1000 }

      negatives = numbers.select{ |n| n < 0 }
      if negatives.any?
        raise ArgumentError, "input has negative numbers: #{negatives.join(", ")}"
      end

      numbers.inject(:+) || 0
    end

    private

    def extract_delimiter_and_input(delimiter_and_input)
      match = DELIMITER_REGEXP.match(delimiter_and_input)
      if match
        input = delimiter_and_input.sub(match[0], '')
        delimiter = match[1] || match[2]
      else
        input = delimiter_and_input
        delimiter = /[,\n]/
      end
      [delimiter, input]
    end

  end
end
