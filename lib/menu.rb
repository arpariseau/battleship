require 'pry'
require './lib/ship.rb'


class Menu
  attr_reader :ships, :height, :width

  def initialize
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @ships = [cruiser, submarine]
    @height = 4
    @width = 4
  end

  def default
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @height = 4
    @width = 4
    @ships = [cruiser, submarine]
  end

  def get_computer_ships
    @ships.map do |ship|
      name = ship.name
      length = ship.length
      ship = Ship.new(name, length)
    end
  end

  def change_board_size(new_height, new_width)
    @height = new_height
    @width = new_width
  end

  def change_board_input
    p "Please enter the new board height:"
    new_height = gets.chomp.to_i
    p "Please enter the new board width:"
    new_width = gets.chomp.to_i
    board_size = new_height * new_width
    until board_size > @ships.sum {|ship| ship.length}
      p "The board is not big enough, please re-enter values."
      p "Please enter the new board height:"
      new_height = gets.chomp.to_i
      p "Please enter the new board width:"
      new_width = gets.chomp.to_i
      board_size = new_height * new_width
    end
    change_board_size(new_height, new_width)
  end

  def options
    p "Enter b to change board size"
    p "Enter s to change ships"
    p "Enter d to return to defaults"
    option_input = nil
    until option_input == "b" || option_input == "s" || option_input == "d"
      option_input = gets.chomp.downcase
      if option_input == "b"
        change_board_input
      elsif option_input == "s"
        p "Doesn't work yet, come back later."
      elsif option_input == "d"
        default
      else
        p "Invalid selection."
      end
    end
  end

end
