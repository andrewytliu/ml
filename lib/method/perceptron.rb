require 'matrix'

module ML
  module Learner
    # Implementation of Perceptron Learning Algorithm
    class PerceptronLearner
      include Toolbox
      include LinearToolbox

      # Initialize a perceptron learner
      #
      # @param [Integer] dim the number of dimension
      def initialize dim
        @dim = dim
        self.current_vector = Matrix.column_vector(Array.new(dim + 1, 0))
      end

      # Train with supervised data
      #
      # @param [Hash] data supervised input data (mapping from array to integer)
      # @param [Numeric] threshold the upper bound of the traning iteration
      # @return [Hash] {error, update_count} error in traning and update numbers used
      def train! data, threshold = 1.0/0
        pool = data.to_a
        update = 0

        while true
          break if update >= threshold
          misclassified = false
          order = (0...(pool.size)).to_a.shuffle

          for i in order
            dat, result = pool[i]
            aug_data = Matrix.column_vector(dat)

            if wrongly_classify aug_data, result
              misclassified = true

              update_vector aug_data, result
              update += 1
              break
            end
          end

          break unless misclassified
        end
      end

      # Predict certain data
      #
      # @param [Array] data data in question
      # @return [Integer] prediction
      def predict data
        classify_bool Matrix.column_vector(data)
      end

    protected
      def wrongly_classify x, y
        classify_inner(x) * y <= 0
      end

      def update_vector x, y
        self.current_vector += y * x
      end
    end
  end
end
