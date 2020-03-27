require 'pry'
require './lib/board.rb'

class Computer
  attr_reader :board, :shots

  def initialize
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
