require 'matrix'

module ML
  module Learner
    # Implementation of cyclic coordinate descent learner
    class CyclicDescentLearner
      # Initialize a learner
      #
      # @param [Integer] dim dimension
      def initialize dim, model = :basis
        @dim = dim
        @w = Matrix.column_vector(Array.new(dim + 1, 0))
        @model = model
      end

      # Train with a supervised data
      #
      # @param [Hash] data supervised input data (mapping from array to integer)
      # @param [Integer] iteration the desired iteration number
      def train! data, iteration
        iteration.times do |i|
          v = calc_v i
          eta = calc_eta data, v
          @w += eta * v
        end
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

    private
      def classify data
        (@w.transpose * data)[0,0]
      end

      def calc_eta data, v
        v_t = v.transpose
        w_t = @w.transpose
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
