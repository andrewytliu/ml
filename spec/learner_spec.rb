require 'spec_helper'

describe "Learner" do
  [ML::Learner::PerceptronLearner, ML::Learner::DecisionStumpLearner,
   ML::Learner::AdaptivePerceptronLearner, ML::Learner::PocketLearner,
   ML::Learner::LinearRegressionLearner, ML::Learner::CyclicDescentLearner,
   ML::Learner::LogisticRegressionLearner].each do |method|
    describe method.to_s do
      it "should run #{method.to_s} in 2d" do
        learner = method.new(2)

        generator = ML::Data::Generator2D.new
        data = generator.points_2d(100)

        learner.train! data

        learner.classify_error(data).should < 0.5
      end

      it "should run #{method.to_s} in hyperspace" do
        learner = method.new(4)

        generator = ML::Data::Generator.new(4)
        data = generator.points(100, ML::Data::Generator.generate_vector(4))

        learner.train! data

        learner.classify_error(data).should < 0.5
      end
    end
  end
end
