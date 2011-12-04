module ML
  module Util
    module_function

    def normal_distribution mean, variance
      if @y
        y = @y
        @y = nil
        return y
      end

      theta = 2 * Math::PI * rand
      rho = Math.sqrt(-2 * Math.log(1 - rand))
      scale = variance * rho
      x = mean + scale * Math.cos(theta)
      @y = mean + scale * Math.sin(theta)
      x
    end
  end
end
