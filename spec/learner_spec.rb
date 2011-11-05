require 'spec_helper'

describe "Learner" do
  describe "Perceptron Learner" do
    it "should run perceptron learning in 2d" do
      learner = ML::Learner::PerceptronLearner.new(2)

      generator = ML::Data::Generator2D.new
      data = generator.points_2d(10)

      response = learner.train! data
      error = response[:error]
      update_count = response[:update_count]

      line = learner.line
      line.should.kind_of?(Array).should == true
      line.size.should == 3

      update_count.should > 0
    end

    it "should run perceptron learning in hyperspace" do
      learner = ML::Learner::PerceptronLearner.new(4)

      generator = ML::Data::Generator.new(4)
      data = generator.points(10, ML::Data::Generator.generate_vector(4))

      response = learner.train! data
      error = response[:error]
      update_count = response[:update_count]

      line = learner.line
      line.should.kind_of?(Array).should == true
      line.size.should == 5

      update_count.should > 0
    end
  end

  describe "Adpative Perceptron Learner" do
    it "should run adaptive perceptron learning in hyperspace" do
      learner = ML::Learner::AdaptivePerceptronLearner.new(4, 0.1)

      generator = ML::Data::Generator.new(4)
      data = generator.points(10, ML::Data::Generator.generate_vector(4))

      response = learner.train! data, 1000
      error = response[:error]
      update_count = response[:update_count]

      line = learner.line
      line.should.kind_of?(Array).should == true
      line.size.should == 5

      update_count.should > 0
      update_count.should < 1000
    end
  end

  describe "Pocket Learner" do
    it "should run pocket perceptron learning in hyperspace" do
      learner = ML::Learner::PocketLearner.new(4)

      generator = ML::Data::Generator.new(4)
      data = generator.points(10, ML::Data::Generator.generate_vector(4))

      learner.train! data, 1000

      line = learner.line
      line.should.kind_of?(Array).should == true
      line.size.should == 5
    end
  end

  describe "Decision Stump Learner" do
    it "should run decision stump learning in hyperspace" do
      learner = ML::Learner::DecisionStumpLearner.new(4)

      generator = ML::Data::Generator.new(4)
      data = generator.points(10, ML::Data::Generator.generate_vector(4))

      learner.train! data
      vector = learner.error_vector
      vector.size.should == 4
    end
  end
end
