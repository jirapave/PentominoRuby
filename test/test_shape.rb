require_relative "../lib/pentomino/shape"
require_relative "../lib/pentomino/point"
require "test/unit"

class TestShape < Test::Unit::TestCase
  def test_equal_to?
    x_shape = Pentomino::Shape.new("X")
    x_shape.add_square(Pentomino::Point.new(-1,-1))
    x_shape.add_square(Pentomino::Point.new(0,-1))
    x_shape.add_square(Pentomino::Point.new(1,-1))
    x_shape.add_square(Pentomino::Point.new(0,-2))
    
    alternate_x_shape = Pentomino::Shape.new("X")
    alternate_x_shape.add_square(Pentomino::Point.new(0,-1))
    alternate_x_shape.add_square(Pentomino::Point.new(-1,-1))
    alternate_x_shape.add_square(Pentomino::Point.new(0,-2))
    alternate_x_shape.add_square(Pentomino::Point.new(1,-1))
    
    assert_equal(true, x_shape.equal_to?(alternate_x_shape))
    
    alternate_x_shape = Pentomino::Shape.new("L")
    alternate_x_shape.add_square(Pentomino::Point.new(0,-1))
    alternate_x_shape.add_square(Pentomino::Point.new(-1,-1))
    alternate_x_shape.add_square(Pentomino::Point.new(0,-2))
    alternate_x_shape.add_square(Pentomino::Point.new(1,-1))
    
    assert_equal(false, x_shape.equal_to?(alternate_x_shape))
    
    x_shape = Pentomino::Shape.new("L")
    x_shape.add_square(Pentomino::Point.new(0,-1))
    x_shape.add_square(Pentomino::Point.new(1,-1))
    x_shape.add_square(Pentomino::Point.new(1,-1))
    x_shape.add_square(Pentomino::Point.new(0,-2))
    
    assert_equal(false, x_shape.equal_to?(alternate_x_shape))
    
    alternate_x_shape = Pentomino::Shape.new("L")
    alternate_x_shape.add_square(Pentomino::Point.new(1,-1))
    alternate_x_shape.add_square(Pentomino::Point.new(0,-1))
    alternate_x_shape.add_square(Pentomino::Point.new(0,-2))
    alternate_x_shape.add_square(Pentomino::Point.new(1,-1))
    
    assert_equal(true, x_shape.equal_to?(alternate_x_shape))
  end
end