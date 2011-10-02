require 'matrix'

module ML
  class Generator
    # Generate point from line
    #
    # @param [Array] [a,b,c] for ax+by+c=0
    # @param [Number] x value
    # @returning [Array] 
    def self.point_from_line coef, x
      [x, (-coef[2]-(coef[0] * x))/coef[1]]
    end

    # Initialize a generator
    #
    # @param [Integer] x range
    # @param [Integer] y range
    def initialize x_range = 100, y_range = 100
      @x_range = x_range
      @y_range = y_range
    end

    # Generate two groups of points
    #
    # @param [Integer] the number of points of each set
    # @param [Array] [a,b,c] for ax+by+c=0
    # @returning [Array] two sets of points
    def points_2d points, coef = [-1.0, 1.0, 0.0]
      result = []
      # for each group
      [1, -1].each do |grp|
        result << []

        points.times do
          while true
            point = generate_point
            prod = Matrix.column_vector(point).transpose * Matrix.column_vector(coef)
            if (prod[0,0] <=> 0) == grp
              result[-1] << point
              break
            end
          end
        end
      end
      result
    end

  private
    def generate_point
      [@x_range * rand, @y_range * rand, 1.0]
    end
  end
end
