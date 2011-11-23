require_relative "../lib/pentomino/point"
require "test/unit"

class TestPoint < Test::Unit::TestCase
  def test_rotate()
    point = Pentomino::Point.new(1,0)
    point.rotate(90)
    assert_equal(true, (point.x == 0 and point.y == 1))
    point.rotate(90)
    assert_equal(true, (point.x == -1 and point.y == 0))
    point.rotate(180)
    assert_equal(true, (point.x == 1 and point.y == 0))
    point.rotate(360)
    assert_equal(true, (point.x == 1 and point.y == 0))
    
    point = Pentomino::Point.new(-2,1)
    point.rotate(90)
    assert_equal(true, (point.x == -1 and point.y == -2))
    point.rotate(180)
    assert_equal(true, (point.x == 1 and point.y == 2))
    point.rotate(270)
    assert_equal(true, (point.x == 2 and point.y == -1))
  end
end