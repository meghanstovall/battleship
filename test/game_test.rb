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
end
