require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/board.rb'
require './lib/computer.rb'

class ComputerTest < Minitest::Test

 def test_it_exists
   computer = Computer.new
   assert_instance_of Computer, computer
 end

 def test_it_has_attributes
   computer = Computer.new

   assert_instance_of Board, computer.board
   assert_equal [], computer.shots
 end
end
