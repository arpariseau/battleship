require './lib/ship.rb'

class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if !empty?
      @ship.hit
    end
  end

  def render(show_ship = false)
    if !fired_upon? && (show_ship && !empty?)
      return "S"
    elsif !fired_upon?
      return "."
    elsif fired_upon? && empty?
      return "M"
    elsif fired_upon? && @ship.sunk?
      return "X"
    else
      return "H"
    end
  end

end
