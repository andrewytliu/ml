require 'matrix'

module ML
  module Learner

    # General toolbox for learning methods
    module Toolbox
      # Predict a single data with current prediction
      #
      # @param [Array] data input vector array
      # @return [Integer] classified data
      def predict data
        raise "Cannot predict"
      end

    protected
      # Calculating model error 
      #
      # @param [Hash] data
      #   supervised input data (mapping from array to integer)
      def classify_error supervised_data
        error = 0

        for data, result in supervised_data
          classified_result = predict(data)
          error += 1 unless result == classified_result
        end

        error.to_f / supervised_data.size
      end
    end

    # Learner toolbox for linear model
    #
    # The prediction is a vector of dimension d+1 where d is the
    # dimension of the input data
    module LinearToolbox
      # Current prediction vector
      attr_accessor :current_vector

      # The final coefficient of the line
      #
      # @return [Array] [a,b,c] for ax+by+c=0 for 2-d case
      def line
        current_vector.column(0).to_a
      end

    protected
      # Classify with single data with 0/1 error
      #
      # @param [Matrix] data input column vector
      # @return [Integer] classified data
      def classify_bool data
        classify_inner(data) <=> 0
      end

      # Classify with single data with inner product
      #
      # @param [Matrix] data input column vector
      # @return [Integer] classified data
      def classify_inner data
        (current_vector.transpose * data)[0,0]
      end
    end
  end
end