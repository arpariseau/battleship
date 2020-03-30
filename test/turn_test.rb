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

  def test_player_can_fire
    cruiser = Ship.new("Cruiser", 3)
    @turn.computer.board.place(cruiser, ["A1", "A2", "A3"])
    assert_equal ".", @turn.computer.board.cells["A1"].render
    @turn.fire("A1")
    assert_equal "H", @turn.computer.board.cells["A1"].render
    @turn.fire("A2")
    @turn.fire("A3")
    assert_equal "X", @turn.computer.board.cells["A1"].render
    @turn.fire("A4")
    assert_equal "M", @turn.computer.board.cells["A4"].render
  end

  def test_fire_output
    cruiser = Ship.new("Cruiser", 3)
    @turn.computer.board.place(cruiser, ["A1", "A2", "A3"])
    @turn.fire("A1")
    @turn.fire_output("A1")
    @turn.fire("A2")
    @turn.fire("A3")
    @turn.fire_output("A3")
    @turn.fire("A4")
    @turn.fire_output("A4")
  end

  def test_start_can_run
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    @turn.computer_setup([cruiser2, submarine2])
    @turn.setup([cruiser, submarine])
    @turn.start
  end



end
