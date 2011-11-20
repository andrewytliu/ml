require 'matrix'

module ML
  module Learner
    # Implementation of linear regression
    class LinearRegressionLearner
      # Intialize linear regression
      #
      # @param [Integer] dim the input dimension
      def initialize dim
        @dim = dim
        @w = []
      end

      # Train with supervised data
      #
      # @param [Hash] data supervised input data (mapping from array to integer)
      def train! data
        x = Matrix.rows(data.keys)
        ary_y = []
        for k in data.keys
          ary_y << data[k]
        end
        y = Matrix.column_vector(ary_y)

        x_t = x.transpose
        x_dag = (x_t * x).inverse * x_t
        @w = x_dag * y
      end

      # Predict certain data
      #
      # @param [Array] data data in question
      # @return [Integer] prediction
      def predict data
        classify(Matrix.column_vector(data + [1.0])) <=> 0
      end

      # The final coefficient of the line
      #
      # @return [Array] [a,b,c] for ax+by+c=0
      def line
        @w.column(0).to_a
      end

    protected
      def classify data
        (@w.transpose * data)[0,0]
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