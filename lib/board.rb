require './lib/ship.rb'
require './lib/cell.rb'
require "pry"

class Board
  attr_reader :cells

  def initialize
    coord = ["A1", "A2", "A3", "A4",
             "B1", "B2", "B3", "B4",
             "C1", "C2", "C3", "C4",
             "D1", "D2", "D3", "D4"]
    @cells = {}
      coord.each do |coord|
        @cells[coord] = Cell.new(coord)
      end
  end

  def valid_coordinate?(cell)
    @cells.has_key?(cell)
  end

  def valid_placement?(ship, coords)
    if ship.length != coords.length
      false
    elsif !coords.map {|coord| valid_coordinate?(coord)}.all?
      false
#    elsif !cons_placement?(coords)
#      false
    else
      true
    end
  end

  def cons_placement?(coords)
    rows = []
    cols = []
    coords.each do |coord|
      row = coord[0]
      rows << row
      col = coord[1].to_i
      cols << col
    end
#    binding.pry
    if rows.uniq.length > 1 && cols.uniq.length > 1
     false
    elsif rows.uniq.length == 1
  #   binding.pry
  #   horizontal_cons(cols)
     false
    else
  #   vertical_cons(rows)
     false
    end
  end

end
