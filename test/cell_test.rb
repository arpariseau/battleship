require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
  end

  def test_existence
    assert_instance_of Cell, @cell
  end

  def test_coordinate_access
    assert_equal "B4", @cell.coordinate
  end

  def test_ship_access
    assert_nil @cell.ship
  end

end
