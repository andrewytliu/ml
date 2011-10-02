require 'rubyvis'

module ML
  class Plotter
    # Initializer of plotter
    #
    # @param [Integer] x value range
    # @param [Integer] y value range
    # @param [Integer] x plot size
    # @param [Integer] y plot size
    def initialize x_range = 100, y_range = 100, x_size = 100, y_size = 100
      @x_range = x_range
      @y_range = y_range
      @x_size = x_size
      @y_size = y_size
    end

    # Plotting 2D data as well as line
    #
    # @param [Array] points to plot
    # @param [Array] line coeffecient
    # @returning [String] svg graph
    def plot points, line = nil
      x = pv.Scale.linear(0, @x_range).range(0, @x_size)
      y = pv.Scale.linear(0, @y_range).range(0, @y_size)

      vis = pv.Panel.new.width(@x_size).height(@y_size)
              .bottom(20).left(20).right(10).top(5)
      
      vis.add(pv.Rule).data(y.ticks()).bottom(y)
         .stroke_style(lambda {|d| d!=0 ? "#eee" : "#000"})
         .anchor("left").add(pv.Label)
         .visible(lambda {|d|  d > 0 and d < 100})
         .text(y.tick_format)
 
      vis.add(pv.Rule).data(x.ticks()).left(x)
         .stroke_style(lambda {|d| d!=0 ? "#eee" : "#000"})
         .anchor("bottom").add(pv.Label)
         .visible(lambda {|d|  d > 0 and d < 100})
         .text(x.tick_format)

      vis.add(pv.Panel)

      vis.add(pv.Dot).data(points[0])         
         .left(lambda {|d| x.scale(d[0])})
         .bottom(lambda {|d| y.scale(d[1])})
         .shape("cross")
         .stroke_style("#000")
      vis.add(pv.Dot).data(points[1])
         .left(lambda {|d| x.scale(d[0])})
         .bottom(lambda {|d| y.scale(d[1])})
         .shape("circle")
         .stroke_style("#000")
      
      if line
        vis.add(pv.Line).data(line)
           .left(lambda {|d| x.scale(d[0])})
           .bottom(lambda {|d| y.scale(d[1])})
      end

      vis.render
      vis.to_svg
    end
  end
end
