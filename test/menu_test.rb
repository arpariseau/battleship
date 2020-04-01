require 'minitest/autorun'
require 'minitest/pride'
require './lib/menu.rb'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/board.rb'

class MenuTest < Minitest::Test

  def setup
    @menu = Menu.new
  end

  def test_existence
    assert_instance_of Menu, @menu
  end

  def test_default_attributes
    assert_equal 2, @menu.ships.length
    assert_equal 4, @menu.height
    assert_equal 4, @menu.width
  end

  def test_return_to_defaults
    skip
    @menu.default
    assert_equal 2, @menu.ships.length
    assert_equal 4, @menu.height
    assert_equal 4, @menu.width
  end

  def test_get_ships
    ships = @menu.ships
    assert_equal "Cruiser", ships[0].name
  end

  def test_get_computer_ships
    comp_ships = @menu.get_computer_ships
    refute_equal @menu.ships[0], comp_ships[0]
    assert_instance_of Ship, comp_ships[0]
  end

  def test_change_board_size
    @menu.change_board_size(6, 6)
    assert_equal 6, @menu.height
    assert_equal 6, @menu.width
  end

  def test_board_input
    skip
    @menu.change_board_input
  end

  def test_can_add_ships
    @menu.add_ship("Battleship", 4)
    assert_equal 3, @menu.ships.length
    assert_equal "Battleship", @menu.ships[2].name
    assert_equal 4, @menu.ships[2].length
  end

  def test_add_ship_input
    skip
    @menu.add_ship_input
  end

  def test_add_ship_input
    skip
    @menu.add_ship("Battleship", 4)
    @menu.add_ship("Destroyer", 1)
    @menu.add_ship_input
  end

  def test_remove_ship
    @menu.remove_ship("Submarine")
    assert_equal 1, @menu.ships.length
    assert_equal "Cruiser", @menu.ships[0].name
    assert_equal 3, @menu.ships[0].length
  end

end
