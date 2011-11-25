require_relative "shape"
require_relative "point"
require_relative "shapes_reader"

module Pentomino
  #Class represents a manager for all the shapes. It is responsible for loading shapes from file,
  #creation of their rotated versions and mirrored versiones. New shapes can be inserted directly.
  class ShapesManager
    attr_accessor :shapes
    def initialize()
      @shapes = {}
    end

    #Method adds a new shape to the list of shapes with all the rotated and mirrored version for it
    #which are not equal to the base shape. Rotation is applied for 90°, 180° and 270°
    def add_shape(shape)
      temp = []
      angles = %w(90 180 270)
      temp << shape
      angles.each do |angle|
        temp << rotate_shape(shape,angle.to_i)
      end
      reverse_shape = reverse_by_y_axis(shape)
      temp << reverse_shape
      angles.each do |angle|
        temp << rotate_shape(reverse_shape,angle.to_i)
      end
      iter = 0
      #We have to delete those shapes, which are equal when rotated for a certain angle, for example I shape, X shape...
      while iter < temp.length
        t_shape = temp[iter]
        delete_those = []
        (iter+1).upto(temp.length-1) do |i|
          if t_shape.equal_to?(temp[i])
          delete_those << i
          end
        end
        delete_those.reverse_each do |index|
          temp.delete_at(index)
        end
        iter += 1
      end

      temp.each do |shape|
        @shapes[@shapes.length+1] = shape
      end
    end

    #Method will read all the shapes in a file and adds them into list
    def generate_shapes(file_path)
      Pentomino::ShapesReader.read_shapes(file_path) do |shape|
        add_shape(shape)
      end
    end

    private

    #This method rotates given shape in a given angle and returns newly created rotated shape
    #Only 90°,180°, 270° angle should be used! Otherwise there could be incosistencies in shapes
    def rotate_shape(input, angle)
      #Shape has it's own representation, which is effectively used throughout the project. But here
      #we have to rotate it and than transform back to that representation
      shape = input.copy
      top_left_point = nil
      ind = 0;
      shape.squares.each_with_index do |square, index|
        square.rotate(angle)
        top_left_point = square if top_left_point == nil

        #Simultaneously we are searching for the most top-left point to fix representation after transformation
        if top_left_point.y < square.y
        top_left_point = square
        ind = index
        elsif top_left_point.y == square.y and top_left_point.x > square.x
        top_left_point = square
        ind = index
        end
      end

      recompute_top_left(shape, top_left_point, ind)
      return shape
    end

    def reverse_by_y_axis(input)
      shape = input.copy
      top_left_point = nil
      ind = 0;
      shape.squares.each_with_index do |square, index|
        if index != 0
        square.y *= -1
        end
        
        top_left_point = square if top_left_point == nil

        #Simultaneously we are searching for the most top-left point to fix representation after transformation
        if top_left_point.y < square.y
        top_left_point = square
        ind = index
        elsif top_left_point.y == square.y and top_left_point.x > square.x
        top_left_point = square
        ind = index
        end
      end
      
      recompute_top_left(shape, top_left_point, ind)
      
      return shape
    end
    
    def recompute_top_left(shape, top_left_point, ind)
      #Now we will fix the representation, e.g. most top-left point to 0,0 and shift others
      x_shift = -1*(top_left_point.x)
      y_shift = -1*(top_left_point.y)
      shape.squares.each do |square|
      square.x += x_shift
        square.y += y_shift
      end
      #At this point, point with index ind should be 0,0, we will move him to be first
      point = shape.squares[ind].copy
      shape.squares.delete_at(ind)
      shape.squares.insert(0, point)
      return shape
    end
  end
end