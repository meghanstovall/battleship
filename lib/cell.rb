require 'colorize'

class Cell

  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    return true if @ship == nil
    false
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    if @ship != nil
      @ship.hit
    end
    @fired_upon = true
  end

  def render(value = false)
    if @fired_upon && empty?
      "M".cyan
    elsif @fired_upon && !empty? && @ship.sunk
      "X".red
    elsif @fired_upon && !empty?
      "H".green
    elsif !@fired_upon && !empty? && value
      "S".black
    else
      "."
    end
  end
end
