module ML
  module Learner
    # Implementation of pocket learning algorithm
    class PocketLearner < PerceptronLearner
      # Train with supervised data
      #
      # @param [Hash] data supervised input data (mapping from array to integer)
      # @param [Integer] iteration the number of the iterations
      def train! data, iteration
        pool = data.to_a
        best_error = classify_error pool

        iteration.times do
          break if best_error == 0
          # the random order
          order = (1...(pool.size)).to_a.shuffle

          for i in order
            dat, result = pool[i]
            aug_data = Matrix.column_vector(dat)

            if wrongly_classify aug_data, result
              update_vector aug_data, result
              break
            end
          end
        end
      end
    end
  end
end