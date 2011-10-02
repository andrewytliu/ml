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
        splitted = line.split
        result[splitted[1,-1]] = splitted[0]
      end

      result
    end
  end
end
