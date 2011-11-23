module Pentomino
  #Class represents a 2D point woth coordinates x,y
  class Point
    attr_accessor :x, :y
    #Initialization of point using x and y coordinates
    def initialize(x_axis, y_axis)
      @x = x_axis
      @y = y_axis
    end

    #Method creates a deep copy of this point
    def copy()
      Point.new(@x,@y)
    end

    #Method will rotate this point around 0,0 with a given degrees
    def rotate(degrees)
      radians = degrees * Math::PI/180
      cos = Math.cos(radians); sin = Math.sin(radians)
      x = (@x*cos - @y*sin).round.to_int
      y = (@x*sin + @y*cos).round.to_int
      @x = x
      @y = y
    end
  end
end