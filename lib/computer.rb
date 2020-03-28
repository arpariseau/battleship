require 'pry'
require './lib/board.rb'

class Computer
  attr_reader :board, :shots

  def initialize
    @board = Board.new
    @shots = []
  end

  def place_ship(ship)
    start_coord = get_random_coordinate
    place_orient = rand(0..1)
    place_coords = []
    until @board.ships.include?(ship.name)
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
    #return array of valid coordinates
  end

  def vert_place_check(ship_length, start_coord)
    #return array of valid coordinates
  end

  def valid_shot?(coord)
    #check if coordinate argument is in @shots array
    #if not, return true, if it is, return false
  end

  def attack
    #get random coordinate
    #use valid_shot? to check and make sure it can be
    #fired upon, if true, then return the coordinate
    #be able to rerun automatically if valid_shot? is false
  end

  def get_random_coordinate
    @board.cells.keys.shuffle[0]
  end

end
