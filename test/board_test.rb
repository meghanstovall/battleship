gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_it_has_cells
    board = Board.new

    assert_instance_of Hash, board.cells
    assert_instance_of Cell, board.cells["A1"]
  end

  def test_that_its_a_valid_coordinate
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_valid_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(cruiser, ["A4", "A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal true, board.valid_placement?(cruiser, ["A2", "A3", "A4"])
  end

  def test_coordinates_consecutive
    board = Board.new
    coordinates1 = ["A1", "B1"]
    coordinates2 = ["A1", "D1"]
    coordinates3 = ["A1", "A2", "A3"]
    coordinates4 = ["B1", "C1", "D1"]

    assert_equal true, board.coordinates_consecutive(coordinates1)
    assert_equal false, board.coordinates_consecutive(coordinates2)
    assert_equal true, board.coordinates_consecutive(coordinates3)
    assert_equal true, board.coordinates_consecutive(coordinates4)
  end

  def test_letters_consecutive
    board = Board.new

    board.letter_array = ["A", "B"]
    assert_equal true, board.letters_consecutive

    board.letter_array = ["A", "D"]
    assert_equal false, board.letters_consecutive

    board.letter_array = ["A", "A", "A"]
    assert_equal false, board.letters_consecutive

    board.letter_array = ["B", "C", "D"]
    assert_equal true, board.letters_consecutive
  end

  def test_numbers_consecutive
    board = Board.new

    board.number_array = ["1", "1"]
    assert_equal false, board.numbers_consecutive

    board.number_array = ["1", "1"]
    assert_equal false, board.numbers_consecutive

    board.number_array = ["1", "2", "3"]
    assert_equal true, board.numbers_consecutive

    board.number_array = ["1", "2", "3"]
    assert_equal true, board.numbers_consecutive
  end

  def test_same_letters
    board = Board.new

    board.letter_array = ["B", "B"]
    assert_equal true, board.same_letters

    board.letter_array = ["A", "D"]
    assert_equal false, board.same_letters

    board.letter_array = ["A", "A", "A"]
    assert_equal true, board.same_letters

    board.letter_array = ["B", "C", "D"]
    assert_equal false, board.same_letters
  end

  def test_same_numbers
    board = Board.new

    board.number_array = ["1", "1"]
    assert_equal true, board.same_numbers

    board.number_array = ["1", "2"]
    assert_equal false, board.same_numbers

    board.number_array = ["2", "2", "2"]
    assert_equal true, board.same_numbers

    board.number_array = ["1", "2", "3"]
    assert_equal false, board.same_numbers
  end

  def test_board_can_place_a_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_instance_of Cell, cell_1
    assert_instance_of Cell, cell_2
    assert_instance_of Cell, cell_3

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert_equal true, cell_3.ship == cell_2.ship
  end

  def test_ships_cant_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
    assert_equal true, board.valid_placement?(submarine, ["B1", "B2"])
  end

  def test_board_can_be_rendered
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", board.render
    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", board.render(true)
  end
end
