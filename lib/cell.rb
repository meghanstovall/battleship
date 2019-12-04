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
    if @ship != nil && @ship.health > 0
      @ship.health -= 1
    end
    @fired_upon = true
  end

  def render(value = false)
    if value == true
      "S"
    elsif @fired_upon == false
      "."
    elsif @fired_upon == true && @ship == nil
      "M"
    elsif @fired_upon == true && @ship.sunk == true
      "X"
    elsif @fired_upon == true && @ship != nil
      "H"
    end
  end

end
