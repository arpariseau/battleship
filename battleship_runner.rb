require './lib/ship.rb'
require './lib/cell.rb'
require './lib/board.rb'
require './lib/computer.rb'
require './lib/turn.rb'
require "pry"

p "Welcome to BATTLESHIP"

player_input = nil
until player_input == "q"
  p "Enter p to play. Enter q to quit."
    player_input = gets.chomp.downcase
  if player_input == "q"
    p "Have a great day"
  elsif player_input == "p"
    turn = Turn.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)

    player_ships = [cruiser, submarine]
    computer_ships = [cruiser2, submarine2]

    turn.setup_output(player_ships)
    turn.setup(player_ships, computer_ships)
    turn.player_turn
  else
    p "Invalid selection."
  end
end
