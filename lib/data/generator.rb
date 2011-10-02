require 'matrix'

module ML
  module Generator
    mattr_accessor :x_range, :y_range
    # Generate two groups of points
    #
    # @param [Integer] the number of points of each set
    # @param [Array] [a,b,c] for ax+by+c=0
    # @returning [Array] two sets of points
    def self.2d_points points, coef = [-1, 1, 0]
      result = []
      # for each group
      [1, -1].each do |grp|
        result << []

        points.times do
          while true
            point = self.generate_point
            prod = Matrix[point].transpose * Matrix[coef]
            if (prod <=> 0) == grp
              result[-1] << point
              break
            end
          end
        end
      end
      result
    end

  private
    def self.generate_point
      [@@x_range * rand, @@y_range * rand, 1.0]
    end
  end
end
