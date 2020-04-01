require './lib/ship.rb'
require './lib/cell.rb'
require './lib/board.rb'
require './lib/computer.rb'
require './lib/turn.rb'
require './lib/menu.rb'
require "pry"

p "Welcome to BATTLESHIP"
player_input = nil
menu = Menu.new
until player_input == "q"
  p "Enter p to play. Enter q to quit. Enter o for options."
    player_input = gets.chomp.downcase
  if player_input == "q"
    p "Have a great day!"
  elsif player_input == "o"
    menu.options
  elsif player_input == "p"
    turn = Turn.new(menu.height, menu.width)
    turn.setup_output(menu.ships)
    turn.setup(menu.ships, menu.get_computer_ships)
    turn.player_turn
  else
    p "Invalid selection."
  end
end
