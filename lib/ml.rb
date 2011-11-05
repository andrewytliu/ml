require 'rubygems'
require 'bundler/setup'

require 'data/plotter'
require 'data/generator'
require 'data/parser'

require 'method/perceptron'
require 'method/adaptive_perceptron'
require 'method/pocket'
require 'method/decision_stump'

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
