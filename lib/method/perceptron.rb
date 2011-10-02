require 'matrix'

module ML
  # Implementation of Perceptron Learning Algorithm
  class PerceptronLearner
    # Initialize a perceptron learner
    #
    # @param [Integer] the number of dimension
    def initialize dim
      @dim = dim
      @w = Matrix[Array.new(dim, 0)]
    end

    # Train with supervised data
    #
    # @param [Hash] supervised input data (mapping from array to integer)
    # @return [PerceptronLearner] self object 
    def train! data
      while true
        misclassified = false

        for dat, result in data
          aug_data = Matrix[[1] + dat]

          if classify(aug_data) != result
            misclassified = true

            @w = @w + result * aug_data
            break
          end
        end

        break unless misclassified
      end
    end

  private
    def classify data
      if @w.transpose * data > 0
        1
      else
        -1
      end
    end
  end
end
