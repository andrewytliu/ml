require 'matrix'

module ML
  # Generating sample points on 2D plane
  class Generator2D
    # Generate point from line
    #
    # @param [Array] [a,b,c] for ax+by+c=0
    # @param [Number] x value
    # @return [Array] 
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

    # Generate two groups of points on 2d plain
    #
    # @param [Integer] the number of points of each set
    # @param [Array] [a,b,c] for ax+by+c=0
    # @return [Array] two sets of points
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

  # General generator for n-dimentional space
  class Generator
    # Initial generator
    #
    # @param [Integer] dimension
    def initialize dim
      @dim = dim
    end

    # Generate two groups of points
    #
    # @param [Integer] the number of points of each set
    # @param [Array] array of the size of dimension to specify the hyper plane
    # @return [Array] two sets of points
    def points_2d points, coef
      result = []
      # for each group
      [1, -1].each do |grp|
        result << []

        points.times do
          while true
            point = generate_vector
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

    def generate_vector
      result = []
      @dim.times { result << rand }
      result
    end
  end
end
