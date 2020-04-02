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
        change_ship_input
      elsif option_input == "d"
        default
      else
        p "Invalid selection."
      end
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
    ship_not_longer_than_height = @ships.max_by {|ship| ship.length}.length <= new_height
    ship_not_longer_than_width = @ships.max_by {|ship| ship.length}.length <= new_width
    until can_fit_all_ships && not_longer_than_max && ship_not_longer_than_height && ship_not_longer_than_width
      p "The board cannot be made, please re-enter values."
      p "Please enter the new board height:"
      new_height = gets.chomp.to_i
      p "Please enter the new board width:"
      new_width = gets.chomp.to_i
      board_size = new_height * new_width
      can_fit_all_ships = (board_size > @ships.sum {|ship| ship.length})
      not_longer_than_max = (new_height <= 10 && new_width <= 10)
      ship_not_longer_than_height = @ships.max_by {|ship| ship.length}.length <= new_height
      ship_not_longer_than_width = @ships.max_by {|ship| ship.length}.length <= new_width
    end
    change_board_size(new_height, new_width)
  end

  def add_ship(name, length)
    new_ship = Ship.new(name, length)
    @ships << new_ship
  end

  def add_ship_input
    if @height > @width
      smaller = @width
    elsif @width > @height
      smaller = @height
    else
      smaller = @height
    end
    if @ships.length == smaller
      p "You've reached the maximum number of ships allowed on this board."
      return nil
    end
    p "Please enter the name of the new ship:"
    name = gets.chomp.capitalize
    p "The current board size allows for a ship length of #{smaller}"
    p "Please enter the length of the new ship:"
    length = gets.chomp.to_i
    until length <= smaller && length > 0
      p "That ship cannot be put on the board."
      p "Please enter the length of the new ship:"
      length = gets.chomp.to_i
    end
    add_ship(name, length)
  end

  def remove_ship(delete_ship)
    @ships.delete(@ships.find {|ship| ship.name == delete_ship})
  end

  def remove_ship_input
    if @ships.length == 1
      p "There's only one ship left, please add another before removing it."
      return nil
    end
    name = nil
    until @ships.map{|ship| ship.name == name}.any?
      p "Please enter the name of the ship you want to remove:"
      name = gets.chomp.capitalize
      if !@ships.map{|ship| ship.name == name}.any?
        p "No ship with that name found."
        p "Enter l if you would like to leave. Enter r if you wish to retry."
        break_option = gets.chomp.downcase
      end
      if break_option == "l"
        return nil
      end
    end
    remove_ship(name)
  end

  def change_ship_input
    p "The current list of ships is:"
    p @ships.map {|ship| ship.name}.join(" ")
    ship_option = nil
    until(ship_option == "a" || ship_option == "r")
      p "Enter a to add ships. Enter r to remove ships."
      ship_option = gets.chomp.downcase
      if ship_option == "a"
        add_ship_input
      elsif ship_option == "r"
        remove_ship_input
      else
        p "Invalid selection."
      end
    end
  end

end
