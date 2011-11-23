require_relative "point"

module Pentomino
  #Class represents a shape which can be placed on a desk. Each shape consist of an array of "squares"
  #where each has it's coordinates relative to the top-left square. Type stays the same for the shapes which
  #are only rotated or mirrored
  class Shape
    attr_accessor :type, :squares
    #Type has to be set when creating shape
    def initialize(type)
      @type = type
      @squares = []
      #Base point, all other points must have coordinates (0+-,0+), base is top-left most point of the shape
      @squares << Pentomino::Point.new(0,0)
    end

    #Method adds one square to the shape, note that point represents coordinats relative to 0,0
    #which is base point. Base point is the top-left most square.
    def add_square(point)
      @squares << point
    end

    #Method returns true if the given shape is equal to this shape, e.g. has the same type and for each
    #square in the given shape, this shape has the point with same coordinates but not necessarily on the same
    #position in the array.
    def equal_to?(shape)
      return false if shape.type != @type
      shape.squares.each do |square|
        found = false
        #Shapes don't have to have the same order of squares
        @squares.each do |sq|
          found = true if square.x == sq.x and square.y == sq.y
        end
        return false if !found
      end
      return true
    end

    #Returns a deep copy of this shape
    def copy()
      shape = Shape.new(@type)
      1.upto(@squares.length-1) do |index|
        shape.add_square(@squares[index].copy)
      end
      return shape
    end
    
    #Helper method to print inner representation for this shape.
    def print_shape()
      puts "shape type: #{type}"
      @squares.each do |sq|
          puts "point: #{sq.x}, #{sq.y}"
      end
    end
  end
end