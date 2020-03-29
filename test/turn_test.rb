require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/board.rb'
require './lib/computer.rb'
require './lib/turn.rb'

class TurnTest < Minitest::Test
  def test_it_exists
    turn = Turn.new

    assert_instance_of Turn, turn
  end

  def test_it_has_attributes
    turn = Turn.new

    assert_instance_of Board, turn.player_board
    assert_instance_of Computer, turn.computer
    assert_equal [], turn.player_shots
  end

end
