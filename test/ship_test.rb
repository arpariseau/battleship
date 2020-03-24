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

  def test_ship_can_be_hit
    ship = Ship.new("Cruiser", 3)

    ship.hit

    assert_equal 2, ship.health
  end

  def test_ship_can_be_hit_and_sunk
    ship = Ship.new("Cruiser", 3)

    ship.hit
    assert_equal false, ship.sunk?

    ship.hit
    assert_equal false, ship.sunk?

    ship.hit

    assert_equal true, ship.sunk?
  end

  def test_health_wont_be_negative
    ship = Ship.new("Cruiser", 3)

    ship.hit
    ship.hit
    ship.hit
    ship.hit

    assert_equal 0, ship.health
  end
end
