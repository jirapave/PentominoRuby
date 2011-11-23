require_relative "shape"
require_relative "point"

module Pentomino
  #Class represents a desk where various shapes can be placed. Desk knows which types of shapes
  #were inserted on it and knows it's most top-left free point where no shape was inserted.
  class Desk
    attr_accessor :width, :height, :data, :free_point, :shapes
    def initialize(width, height)
      @width = width
      @height = height
      @data = Array.new(height) { Array.new(width, 0)}
      @free_point = Pentomino::Point.new(0,0)
      @shapes = {}
    end

    #This method is used to enable this class to be used as a real desk and access its inner array representation
    def [](x, y)
      @data[x][y]
    end
 
    #Method will provide setter functionality for an inner array representation. 
    def []=(x, y, value)
      @data[x][y] = value
    end
    
    #Helper method to print current state of the desk
    def print_desk()
      0.upto(@height-1) do |i|
        0.upto(@width-1) do |j|
          print "#{@data[i][j]},"
        end
        puts ""
      end
      puts ""
    end
    
    #Method verifies if the given shape can be inserted on the free point without colliding with other
    #shapes or breaks the bounds of the desk
    def shape_fits?(shape)
      return false if @free_point == nil
      shape.squares.each do |point|
        puts "data nil" if @data == nil
        #Faster than just catch NoMethodError
        y = @free_point.y - point.y
        x = @free_point.x + point.x
        return false if y < 0 or y > @height-1
        return false if x < 0 or x > @width-1
        #return false if @data[y] == nil
        #return false if @data[y][x] == nil
        if @data[y][x] != 0
          return false
        end
      end
      return true
    end
    
    #Method will try to insert shape on a free point, if there is a space, shape is inserted.
    #New free point is computed(most top-left) and true is returned. Otherwise false is returned.
    #This method does not change it's state if the shape cannot be inserted.
    def insert_shape(shape)
      #Id defines posiion in hash table in solver because each rotation and mirroring of shape
      #generates new shape with it's own id. Shape itself knows only it's base shape type.
      type = shape.type
      return false if @free_point == nil
      
      #Not the most effective solution, but the code is better readable this way and it's easier
      shape.squares.each do |point|
        #!! "-" is right, y is coordinate, but array is NOT, don't forget it
        @data[@free_point.y - point.y][@free_point.x + point.x] = type
      end
      @data[@free_point.y][@free_point.x] = type
      @shapes[shape.type] = true
      
      recompute_free_point()
      return true
    end
    
    #Returns true if the desk is solved, e.g. if the desk is filled with shapes
    def solved?
      return true if @free_point == nil
      return false
    end
    
    #Method verifies if the given shape is on the desk. "shape on the desk" means that a shape with the same
    #type is on the desk, rotated or mirrored shapes have all the same type as a base shape
    def contain_shape?(shape)
      return @shapes[shape.type]
    end

    #Creates a deep copy of this desk
    def copy()
      desk = Desk.new(@width,@height)
      0.upto(@height-1) do |i|
        0.upto(@width-1) do |j|
          desk[i,j] = @data[i][j]
        end
      end
      desk.free_point = Pentomino::Point.new(@free_point.x, @free_point.y)
      @shapes.each do |key, value|
        desk.shapes[key] = value
      end
      return desk
    end
    
    private
    #Method will finds the most top-left unoccupied point on the desk or set free_point to nil
    def recompute_free_point()
      0.upto(@height-1) do |i|
        0.upto(@width-1) do |j|
          if @data[i][j] == 0
            @free_point.x = j
            @free_point.y = i
            return true
          end
        end
      end
      @free_point = nil
    end
  end
end