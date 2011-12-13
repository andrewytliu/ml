require 'matrix'

module ML
  module Learner
    # Implementation of Adaptive Perceptron Learning Algorithm
    class AdaptivePerceptronLearner < PerceptronLearner
      # Initialize an adaptive perceptron learner
      #
      # @param [Integer] dim the number of dimension
      # @param [Float] the eta parameter
      def initialize dim, eta = 0.1
        super(dim)
        @eta = eta
      end

    protected
      def wrongly_classify x, y
        classify_inner(x) * y <= 1
      end

      def update_vector x, y
        self.current_vector += @eta * (y - classify_inner(x))* x
      end
    end
  end
end
