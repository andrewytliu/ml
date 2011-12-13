module ML
  module Learner
    # Implementing logistic regression
    class LogisticRegressionLearner
      include Toolbox
      include LinearToolbox

      # Intialize logistic regression
      #
      # @param [Integer] dim the input dimension
      # @param [Numeric] eta the eta parameter
      # @param [Symbol] model the learning model, :variate for variating
      #   learning rate and :fixed for fixed learning rate
      def initialize dim, eta = 0.01, model = :variate
        @dim = dim
        @eta = eta
        @model = model
      end

      # Train with supervised data
      #
      # @param [Hash] data supervised input data (mapping from array to integer)
      # @param [Integer] iteration the number of the iterations
      def train! data, iteration = 1000
        self.current_vector = Matrix.column_vector(Array.new(@dim + 1, 0))

        iteration.times do
          if @model == :variate
            n = (rand * data.size).to_i
            key = data.keys[n]
            self.current_vector -= gradiant(key, data[key]).map {|e| e * @eta }
          else
            sum = Matrix.column_vector(Array.new(@dim + 1, 0))
            for key, value in data
              sum += gradiant key, value
            end
            self.current_vector -= sum.map {|e| e * @eta / data.size }
          end
        end
      end

    protected
      def gradiant x, y
        exp = Math.exp(-y * 2 * (self.current_vector.transpose * Matrix.column_vector(x))[0,0])
        coef = exp * (-2 * y) / (1 + exp)
        Matrix.column_vector(x).map {|e| e * coef}
      end
    end
  end
end
