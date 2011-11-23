require_relative "../lib/pentomino/desk"
require_relative "../lib/pentomino/shape"
require_relative "../lib/pentomino/point"
require "test/unit"

class TestDesk < Test::Unit::TestCase
  def test_shape_fits?
    desk = Pentomino::Desk.new(10,6)
    #Free point is 0,0
    
    #X shape
    x_shape = Pentomino::Shape.new("X")
    x_shape.add_square(Pentomino::Point.new(-1,-1))
    x_shape.add_square(Pentomino::Point.new(0,-1))
    x_shape.add_square(Pentomino::Point.new(1,-1))
    x_shape.add_square(Pentomino::Point.new(0,-2))
    assert_equal(false, desk.shape_fits?(x_shape))
    desk.free_point = Pentomino::Point.new(0,1)
    assert_equal(false, desk.shape_fits?(x_shape))
    desk.free_point = Pentomino::Point.new(1,1)
    assert_equal(true, desk.shape_fits?(x_shape))
    
    #L shape
    l_shape = Pentomino::Shape.new("L")
    l_shape.add_square(Pentomino::Point.new(0,-1))
    l_shape.add_square(Pentomino::Point.new(0,-2))
    l_shape.add_square(Pentomino::Point.new(0,-3))
    l_shape.add_square(Pentomino::Point.new(1,-3))
    desk = Pentomino::Desk.new(10,6) 
    assert_equal(true, desk.shape_fits?(l_shape))
    desk.insert_shape(l_shape)
    desk.free_point = Pentomino::Point.new(1,3)
    assert_equal(false, desk.shape_fits?(x_shape))
    desk.print_desk
    desk.free_point = Pentomino::Point.new(2,1)
    assert_equal(true, desk.shape_fits?(x_shape))
    desk.insert_shape(x_shape)
    desk.print_desk
  end
  
  def test_contain_shape?
    desk = Pentomino::Desk.new(100,100)
    shape = Pentomino::Shape.new("X")
    desk.insert_shape(shape)
    assert_equal(true, desk.contain_shape?(shape))
    shape = Pentomino::Shape.new("A")
    desk.insert_shape(shape)
    shape = Pentomino::Shape.new("B")
    desk.insert_shape(shape)
    shape = Pentomino::Shape.new("A")
    assert_equal(true, desk.contain_shape?(shape))
    shape = Pentomino::Shape.new("B")
    assert_equal(true, desk.contain_shape?(shape))
    shape = Pentomino::Shape.new("C")
    assert_nil(desk.contain_shape?(shape))
  end
end