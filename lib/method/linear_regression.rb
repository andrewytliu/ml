require 'matrix'

module ML
  module Learner
    # Implementation of linear regression
    class LinearRegressionLearner
      include Toolbox
      include LinearToolbox

      # Intialize linear regression
      #
      # @param [Integer] dim the input dimension
      def initialize dim
        @dim = dim
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
        self.current_vector = x_dag * y
      end
    end
  end
end