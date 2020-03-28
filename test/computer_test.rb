require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/board.rb'
require './lib/computer.rb'

class ComputerTest < Minitest::Test

 def setup
   @computer = Computer.new
 end

 def test_it_exists
   assert_instance_of Computer, @computer
 end

 def test_it_has_attributes
   assert_instance_of Board, @computer.board
   assert_equal [], @computer.shots
 end

 def test_can_get_random_coordinate
   rng = @computer.get_random_coordinate
   puts rng
   assert_includes @computer.board.cells.keys, rng
 end

 def test_can_place_ships
   cruiser = Ship.new("Cruiser", 3)
   submarine = Ship.new("Submarine", 2)

   @computer.place_ship(cruiser)
   @computer.place_ship(submarine)

   assert_equal 2, @computer.board.ships.keys.length
 end
end
