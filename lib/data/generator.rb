require 'matrix'

module ML
  module Data
    # General generator for n-dimentional space
    class Generator
      # Initial generator
      #
      # @param [Integer] dim dimension
      # @param [Numeric] scale the magnitude of the vector
      # @param [Numeric] noise the percentage of noise
      def initialize dim, scale = 1, noise = 0
        @dim = dim
        @scale = scale
        @noise = noise
      end

      # Generate two groups of points
      #
      # @param [Integer] points the number of points of each set
      # @param [Array] coef array of the size of dimension to specify the hyper plane
      # @return [Hash] key: points, value: supervised value
      def points points, coef
        result = {}
        # for each group
        [1, -1].each do |grp|
          points.times do
            while true
              point = generate_vector
              prod = Matrix.column_vector(point).transpose * Matrix.column_vector(coef)
              if (prod[0,0] <=> 0) == grp
                result[point] = grp
                break
              end
            end
          end
        end

        if @noise > 0
          flipping = (points * @noise).to_i
          order = (1...points).to_a.shuffle
          for i in 0...flipping
            result[result.keys[order[i]]] *= -1
          end
        end

        result
      end

      # Generating a random vector
      #
      # @param [Integer] dim the dimension of the vector
      # @param [Integer] scale the scale of each component (default [-1,1])
      # @return [Array] random vector
      def self.generate_vector dim, scale = 1
        result = Array.new(dim) { (rand - 0.5) * 2 * scale } 
        result << 1.0
      end

    protected
      def generate_vector
        Generator.generate_vector @dim, @scale
      end
    end

    # Generating sample points on 2D plane
    class Generator2D < Generator
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
      # @param [Numeric] noise the percentage of noise
      def initialize x_range = 100, y_range = 100, noise = 0
        @x_range = x_range
        @y_range = y_range
        @noise = noise
      end

      # Generate two groups of points on 2d plain
      #
      # @param [Integer] points the number of points of each set
      # @param [Array] coef [a,b,c] for ax+by+c=0
      # @return [Hash] key: points, value: supervised value
      def points_2d points, coef = [-1.0, 1.0, 0.0]
        points(points, coef)
      end

    protected
      def generate_vector
        [@x_range * rand, @y_range * rand, 1.0]
      end
    end
  end
end
