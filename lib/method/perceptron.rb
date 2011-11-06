require 'matrix'

module ML
  module Learner
    # Implementation of Perceptron Learning Algorithm
    class PerceptronLearner
      # Initialize a perceptron learner
      #
      # @param [Integer] dim the number of dimension
      def initialize dim
        @dim = dim
        @w = Matrix.column_vector(Array.new(dim + 1, 0))
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

        # check out errors
        error = if update >= threshold
                  classify_error pool
                else
                  0
                end

        {:error => error, :update_count => update}
      end

      # The final coefficient of the line
      #
      # @return [Array] [a,b,c] for ax+by+c=0
      def line
        @w.column(0).to_a
      end

      # Predict certain data
      #
      # @param [Array] data data in question
      # @return [Integer] prediction
      def predict data
        classify(Matrix.column_vector(data + [1.0])) <=> 0
      end

    protected
      def classify data
        (@w.transpose * data)[0,0]
      end

      def wrongly_classify x, y
        classify(x) * y <= 0
      end

      def update_vector x, y
        @w = @w + y * x
      end

      def classify_error supervised_data
        error = 0

        for data, result in supervised_data
          classified_result = (classify(Matrix.column_vector(data)) <=> 0)
          error += 1 unless result == classified_result
        end

        error
      end
    end
  end
end
