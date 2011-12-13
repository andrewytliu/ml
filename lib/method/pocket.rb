module ML
  module Learner
    # Implementation of pocket learning algorithm
    class PocketLearner < PerceptronLearner
      # Train with supervised data
      #
      # @param [Hash] data supervised input data (mapping from array to integer)
      # @param [Integer] iteration the number of the iterations
      def train! data, iteration = 1000
        pool = data.to_a
        best_error, pocket = 1.0/0, nil

        iteration.times do
          # update pocket
          error = classify_error pool
          if error < best_error
            error = best_error
            pocket = current_vector.dup
          end
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