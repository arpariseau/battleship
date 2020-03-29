require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/board.rb'
require './lib/computer.rb'
require './lib/turn.rb'

class TurnTest < Minitest::Test
  def setup
    @turn = Turn.new
  end

  def test_it_exists
    assert_instance_of Turn, @turn
  end

  def test_it_has_attributes
    assert_instance_of Board, @turn.player_board
    assert_instance_of Computer, @turn.computer
    assert_equal [], @turn.player_shots
  end

  def test_can_setup
    skip
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    @turn.setup([cruiser, submarine])
    assert_equal 2, @turn.player_board.ships.length
    assert_equal 2, @turn.computer.board.ships.length
  end

  def test_if_player_lost
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @turn.player_board.place(cruiser, ["A1", "A2", "A3"])
    @turn.player_board.place(submarine, ["C1", "C2"])
    assert_equal false, @turn.player_lost?
    @turn.player_board.cells["A1"].fire_upon
    @turn.player_board.cells["A2"].fire_upon
    @turn.player_board.cells["A3"].fire_upon
    assert_equal false, @turn.player_lost?
    @turn.player_board.cells["C1"].fire_upon
    @turn.player_board.cells["C2"].fire_upon
    assert_equal true, @turn.player_lost?
  end

  def test_if_computer_lost
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @turn.computer.board.place(cruiser, ["A1", "A2", "A3"])
    @turn.computer.board.place(submarine, ["C1", "C2"])
    assert_equal false, @turn.computer_lost?
    @turn.computer.board.cells["A1"].fire_upon
    @turn.computer.board.cells["A2"].fire_upon
    @turn.computer.board.cells["A3"].fire_upon
    assert_equal false, @turn.computer_lost?
    @turn.computer.board.cells["C1"].fire_upon
    @turn.computer.board.cells["C2"].fire_upon
    assert_equal true, @turn.computer_lost?
  end

end
