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
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    @turn.setup([cruiser, submarine])
    assert_equal 2, @turn.player_board.ships.length
    assert_equal 2, @turn.computer.board.ships.length
  end




end
