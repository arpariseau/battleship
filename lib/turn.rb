require 'pry'
require './lib/board.rb'
require './lib/computer.rb'

class Turn
  attr_reader :player_board, :computer, :player_shots

  def initialize(height = 4, width = 4)
    @player_board = Board.new(height, width)
    @computer = Computer.new(height, width)
    @player_shots = []
  end

  def setup(ships)
    p "I have laid out my ships on the grid."
    p "You now need to lay out your #{ships.length} ships."
    ships.each do |ship|
      player_placement(ship)
      @computer.place_ship(ship)
    end
  end

  def player_placement(ship)
    p "The #{ship.name} is #{ship.length} units long."
    print @player_board.render(true).join
    p "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
    player_coord = gets.chomp.upcase.split
    player_coord.sort
    until @player_board.valid_placement?(ship, player_coord)
      print @player_board.render(true).join
      p "Those are invalid coordinates. Please try again:"
      player_coord = gets.chomp.upcase.split
      player_coord.sort
    end
    @player_board.place(ship, player_coord)
  end

  def start
  end

  def fire_selection
  end

  def player_lost?
  end

  def computer_lost?
  end
end
