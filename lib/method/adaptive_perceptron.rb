require 'matrix'

module ML
  module Learner
    # Implementation of Adaptive Perceptron Learning Algorithm
    class AdaptivePerceptronLearner < PerceptronLearner
      # Initialize an adaptive perceptron learner
      #
      # @param [Integer] dim the number of dimension
      # @param [Float] the eta parameter
      def initialize dim, eta
        super(dim)
        @eta = eta
      end

    protected
      def wrongly_classify x, y
        classify(x) * y <= 1
      end

      def update_vector x, y
        @w = @w + @eta * (y - classify(x))* x
      end
    end
  end
end
