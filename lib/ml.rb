require 'rubygems'
require 'bundler/setup'

require 'data/plotter'
require 'data/generator'
require 'data/parser'

require 'method/perceptron'
require 'method/adaptive_perceptron'

# Top namespace for machine learning algorithms
module ML
  # Data processing module
  module Data
  end

  # Learning algorithms
  module Learner
  end
end

MachingLearning = ML
