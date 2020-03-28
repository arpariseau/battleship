require 'pry'
require './lib/board.rb'

class Computer
  attr_reader :board, :shots

  def initialize
    @board = Board.new
    @shots = []
  end

  def place_ship(ship)
    place_orient = rand(0..1)
    place_coords = []
    until @board.ships.include?(ship.name)
      start_coord = get_random_coordinate
      if place_orient == 0
        place_coords = horiz_place_check(ship.length, start_coord)
        @board.place(ship, place_coords)
      else
        place_coords = vert_place_check(ship.length, start_coord)
        @board.place(ship, place_coords)
      end
    end
  end

  def horiz_place_check(ship_length, start_coord)
    start_num = start_coord[1].to_i
    (start_num..((start_num - 1) + ship_length)).map do |num|
      start_coord[0] + num.to_s
    end
  end

  def vert_place_check(ship_length, start_coord)
    start_ltr = start_coord[0]
    (start_ltr.ord..((start_ltr.ord - 1) + ship_length)).map do |ltr|
      ltr.chr + start_coord[1]
    end
  end

  def valid_shot?(coord)
    if @shots.include?(coord)
      false
    else
      true
    end
  end

  def attack
    target = get_random_coordinate

    if valid_shot?(target)
      @board.cells[target].fire_upon
      @shots << target
    else
      attack
    end
  end

  def get_random_coordinate
    @board.cells.keys.shuffle[0]
  end
end
