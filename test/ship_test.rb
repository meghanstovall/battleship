
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.sunk?
# #=> true


gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    cruiser = Ship.new("Cruiser", 3)

    assert_instance_of Ship, cruiser
  end

  def test_attributes_exist_when_created
    cruiser = Ship.new("Cruiser", 3)

    assert_equal "Cruiser", cruiser.name
    assert_equal 3, cruiser.length
    assert_equal 3, cruiser.health
    assert_equal false, cruiser.sunk?
  end

  def test_ship_is_hit
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 2, cruiser.hit
    assert_equal 2, cruiser.health
  end

  def test_ship_has_sunk
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    cruiser.hit
    cruiser.hit
    cruiser.hit

    assert_equal true, cruiser.sunk?
  end
end
