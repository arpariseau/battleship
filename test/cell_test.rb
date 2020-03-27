require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @ship = Ship.new("Cruiser", 3)
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

  def test_emptiness
    assert_equal true, @cell.empty?
    @cell.place_ship(@ship)
    assert_equal false, @cell.empty?
  end

  def test_ship_placement
    @cell.place_ship(@ship)
    assert_equal @ship, @cell.ship
  end

  def test_cell_fired_upon
    assert_equal false, @cell.fired_upon?
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
  end

  def test_ship_fired_upon
    @cell.place_ship(@ship)
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
    assert_equal 2, @cell.ship.health
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
  end

  def test_empty_cell_rendering
    assert_equal ".", @cell.render
    @cell.fire_upon
    assert_equal "M", @cell.render
  end

  def test_ship_cell_rendering
    @cell.place_ship(@ship)
    assert_equal ".", @cell.render
    assert_equal "S", @cell.render(true)
    @cell.fire_upon
    assert_equal "H", @cell.render
  end

  def test_sunk_cell_rendering
    @cell.place_ship(@ship)
    @cell.ship.hit
    @cell.ship.hit
    @cell.fire_upon
    assert_equal "X", @cell.render
  end

end
