require 'rubyvis'

module ML
  module Data
    # Plotting the data to svg
    class Plotter
      # Initializer of plotter
      #
      # @param [Integer] x_range x value range
      # @param [Integer] y_range y value range
      # @param [Integer] x_size x plot size
      # @param [Integer] y_size y plot size
      def initialize x_range = 100, y_range = 100, x_size = 100, y_size = 100
        @x_range = x_range
        @y_range = y_range
        @x_size = x_size
        @y_size = y_size

        @x = pv.Scale.linear(0, @x_range).range(0, @x_size)
        @y = pv.Scale.linear(0, @y_range).range(0, @y_size)

        @vis = pv.Panel.new.width(@x_size).height(@y_size)
                 .bottom(20).left(20).right(10).top(5)
        
        @vis.add(pv.Rule).data(@y.ticks()).bottom(@y)
            .stroke_style(lambda {|d| d!=0 ? "#eee" : "#000"})
            .anchor("left").add(pv.Label)
            .visible(lambda {|d| d > 0 and d < x_range})
            .text(@y.tick_format)
   
        @vis.add(pv.Rule).data(@x.ticks()).left(@x)
            .stroke_style(lambda {|d| d!=0 ? "#eee" : "#000"})
            .anchor("bottom").add(pv.Label)
            .visible(lambda {|d| d > 0 and d < y_range})
            .text(@x.tick_format)

        yield(self) if block_given?
      end

      # Plotting points with shape and color
      #
      # @param [Array] points points to plot
      # @param [String] shape shape of the points
      # @param [String] color color of the points
      def dot points, shape = "circle", color = "#000"
        # FIXME: dirty hack for instance_exec
        x = @x
        y = @y

        @vis.add(pv.Dot).data(points)         
            .left(lambda {|d| x.scale(d[0])})
            .bottom(lambda {|d| y.scale(d[1])})
            .shape(shape)
            .stroke_style(color)
      end

      # Plotting line with color
      #
      # @param [Array] points 2 points which represents line
      # @param [String] color color of the line
      def line points, color = "#000"
        x = @x
        y = @y

        @vis.add(pv.Line).data(points)
            .left(lambda {|d| x.scale(d[0])})
            .bottom(lambda {|d| y.scale(d[1])})
            .stroke_style(color)
      end

      # Convert to svg
      #
      # @return [String] svg plot
      def to_svg
        @vis.render
        @vis.to_svg
      end
    end
  end
end
