require 'rubyviz'

module ML
  class Plotter
    attr_accessor :x_range, :y_range, :x_size, :y_size

    # Plotting 2D data as well as line
    #
    # @param [Array] points to plot
    # @param [Array] line coeffecient
    # @returning [String] svg graph
    def plot points, line = nil
      x = pv.Scale.linear(0, @x_range).range(0, x_size)
      y = pv.Scale.linear(0, @y_range).range(0, y_size)

      vis = pv.Panel.new.width(x_size).height(y_size)
              .bottom(20).left(20).right(10).top(5)
      
      vis.add(pv.Rule).data(y.ticks()).bottom(y)
         .strokeStyle(lambda {|d| d!=0 ? "#eee" : "#000"})
         .anchor("left").add(pv.Label)
         .visible(lambda {|d|  d > 0 and d < 1})
         .text(y.tick_format)
 
      vis.add(pv.Rule)
         .data(x.ticks())
         .left(x)
         .stroke_style(lambda {|d| d!=0 ? "#eee" : "#000"})
         .anchor("bottom").add(pv.Label)
         .visible(lambda {|d|  d > 0 and d < 100})
         .text(x.tick_format);

      vis.add(pv.Panel)
         .data(data)
         .add(pv.Dot)
         .left(lambda {|d| x.scale(d.x)})
         .bottom(lambda {|d| y.scale(d.y)})
         .stroke_style(lambda {|d| c.scale(d.z)})
         .fill_style(lambda {|d| c.scale(d.z).alpha(0.2)})
         .shape_size(lambda {|d| d.z})
         .title(lambda {|d| "%0.1f" % d.z})
      
      vis.render.to_svg
    end
  end
end
