require 'pry'
require './lib/board.rb'

class Computer
  def initialize()
    @board = Board.new
    @shots = []
  end

  def place_ship
  end

  def shot_valid?
  end

  def attack
  end
end
