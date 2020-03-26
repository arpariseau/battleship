require './lib/ship.rb'
require './lib/cell.rb'
require "pry"

class Board
  attr_reader :cells, :ships

  def initialize
    coord = ["A1", "A2", "A3", "A4",
             "B1", "B2", "B3", "B4",
             "C1", "C2", "C3", "C4",
             "D1", "D2", "D3", "D4"]
    @ships = {}
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
    elsif !cons_placement?(coords)
      false
    elsif !coords.map{|coord| @cells[coord].empty?}.all?
      false
    else
      true
    end
  end

  def cons_placement?(coords)
    rows = []
    cols = []
    coords.each do |coord|
      rows << coord[0]
      cols << coord[1].to_i
    end
    horiz_check = (cols.first..cols.last).to_a
    vert_check = (rows.first..rows.last).to_a
    if horiz_check.length > 1 && vert_check.length > 1
      false
    elsif vert_check.length == 1 && cols != horiz_check
      false
    elsif horiz_check.length == 1 && rows != vert_check
      false
    else
      true
    end
  end

  def place(ship, coords)
    if valid_placement?(ship, coords)
      coords.map {|coord| @cells[coord].place_ship(ship)}
      @ships[ship.name] = ship
    end
  end


end
