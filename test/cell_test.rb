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

    assert_equal false, cell.fired_upon
    cell.fire_upon
    assert_equal 2, cell.ship.health
    assert_equal true, cell.fire_upon
  end

  def test_render
    cell_1 = Cell.new("B4")
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    assert_equal ".", cell_1.render
    cell_1.fire_upon
    assert_equal "M", cell_1.render
    cell_2.place_ship(cruiser)
    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
    cell_2.fire_upon
    assert_equal "H", cell_2.render
    assert_equal false, cruiser.sunk?
    cruiser.hit
    cruiser.hit
    assert_equal true, cruiser.sunk?
    assert_equal "X", cell_2.render
  end
end
