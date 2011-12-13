require 'matrix'

module ML
  module Learner
    # Implementation of cyclic coordinate descent learner
    class CyclicDescentLearner
      include Toolbox
      include LinearToolbox

      # Initialize a learner
      #
      # @param [Integer] dim dimension
      def initialize dim, model = :basis
        @dim = dim
        @model = model
      end

      # Train with a supervised data
      #
      # @param [Hash] data supervised input data (mapping from array to integer)
      # @param [Integer] iteration the desired iteration number
      def train! data, iteration = 1000
        self.current_vector = Matrix.column_vector(Array.new(@dim + 1, 0))
        iteration.times do |i|
          v = calc_v i
          eta = calc_eta data, v
          self.current_vector += eta * v
        end
      end

    private

      def calc_eta data, v
        v_t = v.transpose
        w_t = self.current_vector.transpose
        train = {}

        for xn, yn in data
          x_n = Matrix.column_vector(xn)
          dot = (v_t * x_n)[0,0] * yn
          thr = (w_t * x_n)[0,0] * (-yn) / dot
          
          next if dot == 0
          if dot > 0
            train[[thr]] = 1
          else
            train[[thr]] = -1
          end
        end

        learner = DecisionStumpLearner.new(1)
        learner.train! train
        learner.hypothesis[2]
      end

      def calc_v iteration
        v = Array.new(@dim + 1, 0)
        if @model == :basis
          v[iteration % @dim] = 1
        else
          v[iteration % @dim] = Util.normal_distribution 0,1
        end
        Matrix.column_vector(v)
      end
    end
  end
end
