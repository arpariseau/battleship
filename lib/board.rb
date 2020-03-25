require './lib/ship.rb'
require './lib/cell.rb'
require "pry"

class Board
  attr_reader :cells

  def initialize
    coord = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @cells = {}
      coord.each do |coord|
        @cells[coord] = Cell.new(coord)
      end
  end


  end
