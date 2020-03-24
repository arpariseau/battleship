require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'

class PlayerTest < Minitest::Test

  def test_ship_exists
    ship = Ship.new("Cruiser", 3)

    assert_instance_of Ship, ship
  end

  def test_ship_instantiation
    ship = Ship.new("Cruiser", 3)

    assert_equal "Cruiser", ship.name
    assert_equal 3, ship.length
    assert_equal 3, ship.health
  end

  def test_ship_full_health_has_sunk
    ship = Ship.new("Cruiser", 3)

    assert_equal false, ship.sunk?
  end


end
