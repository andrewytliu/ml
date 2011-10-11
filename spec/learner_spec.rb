require 'spec_helper'

describe "Learner" do
  describe "Perceptron Learner" do
    it "should run perceptron learning in 2d" do
      learner = ML::Learner::PerceptronLearner.new(2)

      generator = ML::Data::Generator2D.new
      data = generator.points_2d(10)

      learner.train! data

      line = learner.line
      line.should.kind_of?(Array).should == true
      line.size.should == 3

      learner.update_count.should > 0
    end

    it "should run perceptron learning in hyperspace" do
      learner = ML::Learner::PerceptronLearner.new(4)

      generator = ML::Data::Generator.new(4)
      data = generator.points(10, ML::Data::Generator.generate_vector(4))

      learner.train! data

      line = learner.line
      line.should.kind_of?(Array).should == true
      line.size.should == 5

      learner.update_count.should > 0
    end
  end

  describe "Adpative Perceptron Learner" do
    it "should run adaptive perceptron learning in hyperspace" do
      learner = ML::Learner::AdaptivePerceptronLearner.new(4, 0.1)

      generator = ML::Data::Generator.new(4)
      data = generator.points(10, ML::Data::Generator.generate_vector(4))

      learner.train! data

      line = learner.line
      line.should.kind_of?(Array).should == true
      line.size.should == 5

      learner.update_count.should > 0
    end
  end
end
