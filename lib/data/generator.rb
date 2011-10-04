require 'matrix'

module ML
  module Data
    # Generating sample points on 2D plane
    class Generator2D
      # Generate point from line
      #
      # @param [Array] coef [a,b,c] for ax+by+c=0
      # @param [Number] x x value
      # @return [Array] point
      def self.point_from_line coef, x
        [x, (-coef[2]-(coef[0] * x))/coef[1]]
      end

      # Initialize a generator
      #
      # @param [Integer] x_range x range
      # @param [Integer] y_range y range
      def initialize x_range = 100, y_range = 100
        @x_range = x_range
        @y_range = y_range
      end

      # Generate two groups of points on 2d plain
      #
      # @param [Integer] points the number of points of each set
      # @param [Array] coef [a,b,c] for ax+by+c=0
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
      # @param [Integer] dim dimension
      def initialize dim
        @dim = dim
      end

      # Generate two groups of points
      #
      # @param [Integer] points the number of points of each set
      # @param [Array] coef array of the size of dimension to specify the hyper plane
      # @return [Array] two sets of points
      def points points, coef
        result = []
        # for each group
        [1, -1].each do |grp|
          result << []

          points.times do
            while true
              point = Generator.generate_vector(@dim)
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

      # Generating a random vector
      #
      # @param [Integer] dim the dimension of the vector
      # @return [Array] random vector
      def self.generate_vector dim
        result = Array.new(dim) { rand - 0.5 } 
        result << 1.0
      end
    end
  end
end
