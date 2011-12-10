require 'rubygems'
require 'bundler/setup'

require 'util/util'

require 'data/plotter'
require 'data/generator'
require 'data/parser'

require 'method/toolbox'

require 'method/perceptron'
require 'method/adaptive_perceptron'
require 'method/pocket'
require 'method/decision_stump'
require 'method/linear_regression'
require 'method/logistic_regression'
require 'method/cyclic_descent'

# Top namespace for machine learning algorithms
module ML
  # Data processing module
  module Data
  end

  # Learning algorithms
  module Learner
  end
end

MachineLearning = ML
