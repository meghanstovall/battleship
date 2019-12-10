gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new()

    assert_instance_of Game, game
  end

  def test_it_has_attributes
    game = Game.new()

    assert_instance_of Board, game.computer_board
    assert_instance_of Board, game.user_board
    assert_instance_of Ship, game.computer_cruiser
    assert_instance_of Ship, game.user_cruiser
    assert_instance_of Ship, game.computer_submarine
    assert_instance_of Ship, game.user_submarine
  end

  def test_place_user_ships
    skip
    game = Game.new()
    user_board = game.user_board
    user_submarine = game.user_submarine

    assert_equal
  end

  def test_board_displays
    game = Game.new()

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", game.board_display
  end
end
