require 'matrix'

module ML
  module Learner
    # Implementation of Perceptron Learning Algorithm
    class PerceptronLearner
      # Initialize a perceptron learner
      #
      # @param [Integer] dim the number of dimension
      def initialize dim, thres = 1.0/0
        @dim = dim
        @w = Matrix.column_vector(Array.new(dim + 1, 0))
        @error = 0
      end

      # Train with supervised data
      #
      # @param [Hash] data supervised input data (mapping from array to integer)
      # @param [Numeric] threshold the upper bound of the traning iteration
      def train! data, thres = 1.0/0
        pool = data.to_a
        @update = 0
        @threshold = thres

        while true
          break if @update >= @threshold
          misclassified = false
          order = (1...(pool.size)).to_a.shuffle

          for i in order
            dat, result = pool[i]
            aug_data = Matrix.column_vector(dat)

            if wrongly_classify aug_data, result
              misclassified = true

              update_vector aug_data, result
              @update += 1
              break
            end
          end

          break unless misclassified
        end

        # check out errors
        if @update >= @threshold
          for dat, result in pool
            classified_result = (classify(Matrix.column_vector(dat)) <=> 0)
            @error += 1 unless result == classified_result
          end
        end
      end

      # The number of errors when the training process is stopped by threshold
      #
      # @return [Integer] error error numbers
      def error
        @error
      end

      # The final coefficient of the line
      #
      # @return [Array] [a,b,c] for ax+by+c=0
      def line
        @w.column(0).to_a
      end

      # The number for updates
      #
      # @return [Integer] update count
      def update_count
        @update
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
    end
  end
end
