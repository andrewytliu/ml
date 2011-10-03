module ML
  # Parser for traing/testing data
  class Parser
    # Parse the vector file with supervised result
    #
    # @return [Hash] map from data to supervised result
    def parse_supervised filename
      result = {}
      lines = IO.readlines(filename)

      lines.each do |line|
        splitted = line.split.map(&:to_f)
        result[splitted[1..-1] + [1.0]] = splitted[0]
      end

      result
    end

    # Parse the vector file
    #
    # @return [Array] array of vectors
    def parse_unsupervised filename
      lines = IO.readlines(filename)
      lines.map {|line| line.split.map(&:to_f) }
    end
  end
end
