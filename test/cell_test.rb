gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_attributes
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
    assert_equal nil, cell.ship
    assert_equal true, cell.empty?
  end

  def test_place_ship
    cell = Cell.new("B4")
    ship = Ship.new("Cruiser", 3)
    cell.place_ship(ship)

    assert_equal ship, cell.ship
    assert_equal false, cell.empty?
  end

  def test_ship_is_fired_upon
    cell = Cell.new("B4")
    ship = Ship.new("Cruiser", 3)
    cell.place_ship(ship)

    assert_equal false, cell.fired_upon?
    cell.fired_upon
    assert_equal 2, cell.ship.health
    assert_equal true, cell.fired_upon
  end

end
