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
    p "Max board size that can be displayed is 10 x 10"
    p "Please enter the new board height:"
    new_height = gets.chomp.to_i
    p "Please enter the new board width:"
    new_width = gets.chomp.to_i
    board_size = new_height * new_width
    can_fit_all_ships = (board_size > @ships.sum {|ship| ship.length})
    not_longer_than_max = (new_height <= 10 && new_width <= 10)
    ship_not_longer_than_height = @ships.max_by {|ship| ship.length}.length < new_height
    ship_not_longer_than_width = @ships.max_by {|ship| ship.length}.length < new_width
    until can_fit_all_ships && not_longer_than_max && ship_not_longer_than_height && ship_not_longer_than_width
      p "The board cannot be made, please re-enter values."
      p "Please enter the new board height:"
      new_height = gets.chomp.to_i
      p "Please enter the new board width:"
      new_width = gets.chomp.to_i
      board_size = new_height * new_width
      can_fit_all_ships = (board_size > @ships.sum {|ship| ship.length})
      not_longer_than_max = (new_height <= 10 && new_width <= 10)
      ship_not_longer_than_height = @ships.max_by {|ship| ship.length}.length < new_height
      ship_not_longer_than_width = @ships.max_by {|ship| ship.length}.length < new_width
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
