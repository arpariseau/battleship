require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/board.rb'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_has_cells
    assert_equal 16, @board.cells.keys.length
    assert_equal 16, @board.cells.values.length
    assert_instance_of Cell, @board.cells.values[rand(0..15)]
  end

  def test_can_validate_coordinates
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal false, @board.valid_coordinate?("A5")
  end

  def test_can_validate_placement_length
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(submarine, ["A1", "A2"])
  end

  def test_can_validate_coordinate_placement
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(cruiser, ["A3", "A4", "A5"])
    assert_equal true, @board.valid_placement?(submarine, ["A3", "A4"])
  end

  def test_can_validate_consecutive_placement
    assert_equal false, @board.cons_placement?(["A1", "B2"])
    assert_equal false, @board.cons_placement?(["A1", "A3", "A4"])
    assert_equal false, @board.cons_placement?(["A1", "C1", "D1"])
    assert_equal true, @board.cons_placement?(["A3", "A4"])
  end

  def test_can_validate_cons_placement_with_valid_placement
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, @board.valid_placement?(submarine,["A1", "B2"])
    assert_equal false, @board.valid_placement?(cruiser,["A1", "A3", "A4"])
    assert_equal false, @board.valid_placement?(cruiser,["A1", "C1", "D1"])
    assert_equal true, @board.valid_placement?(submarine,["A3", "A4"])
    assert_equal true, @board.valid_placement?(cruiser,["B1","C1","D1"])
  end

  def test_can_place_ship
    cruiser = Ship.new("Cruiser", 3)
    @board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal cruiser, @board.cells["A1"].ship
    assert_equal cruiser, @board.cells["A2"].ship
    assert_equal cruiser, @board.cells["A3"].ship
  end

  def test_placement_is_empty
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, @board.valid_placement?(cruiser, ["A1", "A2", "A3"])

    @board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal false, @board.valid_placement?(submarine,["A1", "A2"])
  end

  def test_can_render
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    @board.place(cruiser, ["A1", "A2", "A3"])
    @board.place(submarine, ["C1", "D1"])
    assert_includes @board.render, "A . . . . \n"
    assert_includes @board.render(true), "A S S S . \n"
    @board.cells["A1"].fire_upon
    @board.cells["B4"].fire_upon
    assert_includes @board.render, "A H . . . \n"
    assert_includes @board.render(true), "A H S S . \n"
    assert_includes @board.render, "B . . . M \n"
    @board.cells["C1"].fire_upon
    @board.cells["D1"].fire_upon
    assert_includes @board.render, "C X . . . \n"
    assert_includes @board.render, "D X . . . \n"
  end

  def test_flexible_board_definition
    sixboard = Board.new(6, 6)
    assert_includes sixboard.cells.keys, "F6"
  end

end
