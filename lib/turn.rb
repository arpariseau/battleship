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

  def setup(player_ships, computer_ships)
    player_ships.each do |ship|
      player_placement(ship)
    end
    computer_ships.each do |ship|
      @computer.place_ship(ship)
    end
  end

  def setup_output(ships)
    p "I have laid out my ships on the grid."
    p "You now need to lay out your #{ships.length} ships."
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

  def player_turn
    display_board
    player_shot = fire_input
    fire(player_shot)
    fire_output(player_shot)
    if computer_lost?
      p "You won!"
    else
      computer_turn
    end
  end

  def computer_turn
    display_board
    sleep(2.5)
    computer_shot = @computer.attack
    @player_board.cells[computer_shot].fire_upon
    fire_output_computer(computer_shot)
    if player_lost?
      p "I won!"
    else
      player_turn
    end
  end

  def display_board
    p "=============COMPUTER BOARD============="
    print @computer.board.render.join(" ")
    p "==============PLAYER BOARD=============="
    print @player_board.render(true).join(" ")
  end

  def fire(selection)
    @computer.board.cells[selection].fire_upon
    @player_shots << selection
  end

  def fire_input
    p "Enter the coordinate for your shot:"
    coord = gets.chomp.upcase
    if !@computer.board.valid_coordinate?(coord)
      p "This coordinate doesn't exist."
      fire_input
    elsif @player_shots.include?(coord)
      p "This coordinate has already been fired upon."
      p "Do you want to choose a different coordinate? (Y/N)"
      input = gets.chomp.upcase
    end
    if input == "Y"
      fire_input
    else
      coord
    end
  end

  def fire_output(coord)
    if @computer.board.cells[coord].render == "X"
      p "Your shot on #{coord} sunk my #{@computer.board.cells[coord].ship.name}."
    elsif @computer.board.cells[coord].render == "H"
      p "Your shot on #{coord} was a hit."
    else
      p "Your shot on #{coord} was a miss."
    end
  end

  def fire_output_computer(coord)
      if @player_board.cells[coord].render == "X"
        p "My shot on #{coord} sunk your #{@player_board.cells[coord].ship.name}."
      elsif @player_board.cells[coord].render == "H"
        p "My shot on #{coord} was a hit."
      else
        p "My shot on #{coord} was a miss."
      end
    end

  def player_lost?
    @player_board.ships.values.map {|ship| ship.sunk?}.all?
  end

  def computer_lost?
    @computer.board.ships.values.map {|ship| ship.sunk?}.all?
  end
end
