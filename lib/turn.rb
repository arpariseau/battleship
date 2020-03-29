require 'pry'
require './lib/board.rb'
require './lib/computer.rb'

class Turn
  attr_reader :player_board, :computer, :player_shots

  def initialize(height = 4, width = 4)
    @player_board = Board.new(height, width)
    @computer = Computer.new(height, width)
    @player_shots = []
  end

  def setup
  end

  def start
  end

  def fire_selection
  end

  def player_lost?
  end

  def computer_lost?
  end
end
