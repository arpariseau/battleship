require './lib/ship.rb'
require './lib/cell.rb'
require "pry"

class Board
  attr_reader :cells, :ships, :height, :width

  def initialize(height = 4, width = 4)
    @ships = {}
    @cells = {}
    @height = height
    @width = width
    make_cells
  end

  def make_cells
    horiz = 1..@width
    vert = ("A".ord..(("A".ord - 1) + @height)).map {|num| num.chr}
    grid = horiz.map do |num|
      vert.map do |ltr|
        ltr + num.to_s
      end
    end
    coords = grid.flatten
    coords.each do |coord|
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

  def render(show_ship = false)
    col_disp = "  " + (1..@width).to_a.join(" ") + " \n"
    display = [col_disp]
    rows = ("A".ord..(("A".ord - 1) + @height)).map {|num| num.chr}
    rows.each do |ltr|
      display << render_row(ltr, show_ship)
    end
    display
  end

  def render_row(ltr, show_ship)
    ltr_row = @cells.keys.find_all do |key|
      key.include?(ltr)
    end
    row_cells = ltr_row.map do |cell|
      @cells[cell].render(show_ship)
    end
    row_display = ltr + " " + row_cells.join(" ") + " \n"
  end

end
