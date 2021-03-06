require 'pry'
require './lib/board.rb'

class Computer
  attr_reader :board, :shots

  def initialize(height = 4, width = 4)
    @board = Board.new(height, width)
    @shots = []
  end

  def place_ship(ship)
    until @board.ships.include?(ship.name)
      place_orient = rand(2)
      start_coord = get_random_coordinate
      if place_orient == 0
        place_coords = create_horiz_coords(ship.length, start_coord)
        @board.place(ship, place_coords)
      else
        place_coords = create_vert_coords(ship.length, start_coord)
        @board.place(ship, place_coords)
      end
    end
  end

  def create_horiz_coords(ship_length, start_coord)
    start_num = start_coord[1].to_i
    (start_num..((start_num - 1) + ship_length)).map do |num|
      start_coord[0] + num.to_s
    end
  end

  def create_vert_coords(ship_length, start_coord)
    start_ltr = start_coord[0]
    (start_ltr.ord..((start_ltr.ord - 1) + ship_length)).map do |ltr|
      ltr.chr + start_coord[1]
    end
  end

  def valid_shot?(coord)
     !@shots.include?(coord)
  end

  def attack
    target = get_random_coordinate
    until valid_shot?(target)
      target = get_random_coordinate
    end
    @shots << target
    target
  end

  def get_random_coordinate
    @board.cells.keys.shuffle[0]
  end
end
