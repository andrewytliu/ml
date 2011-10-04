require 'spec_helper'

describe "Data" do
  it "should plot a single plot" do
    graph = ML::Data::Plotter.new(100, 100, 100, 100) do |p|
      p.dot [[10,10], [20,20]]
      p.line [[0,50], [100,50]]
    end

    graph.to_svg.kind_of?(String).should == true
  end

  it "should generate points" do
    hyperplane = ML::Data::Generator.generate_vector(4)
    hyperplane.size.should == 5

    generator = ML::Data::Generator.new(4)
    points = generator.points(10, hyperplane)

    points.kind_of?(Hash).should == true
    points.first.kind_of?(Array).should == true
    points.first.first.size.should == 5
  end
end
