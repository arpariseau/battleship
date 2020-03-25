require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/board.rb'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_has_cells
    board = Board.new

    assert_equal 16, board.cells.keys.length
    assert_equal 16, board.cells.values.length
    assert_instance_of Cell, board.cells.values[0]
    assert_instance_of Cell, board.cells.values[15]
  end

  def test_can_validate_coordinates
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal false, board.valid_coordinate?("A5")
  end

  def test_can_validate_placement_length
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
  end

end
