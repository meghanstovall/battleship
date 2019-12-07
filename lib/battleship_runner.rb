require './lib/ship'
require './lib/cell'
require './lib/board'

  board = Board.new()
  cruiser = Ship.new("Cruiser", 3)
  submarine = Ship.new("Submarine", 2)

  def start
    "Welcome to BATTLESHIP"
    "Enter p to play. Enter q to quit"

    user_answer = gets.chomp
      if user_answer == "p"
        play
      else
        quit
      end
    end

  def play
    "I have laid my ships on the grid."
    "You now need to lay out your two ships"
    "The cruiser is three units long and the submarine is two units long"
    board.render

    until board.valid_placement?(cruiser, user_coordinates) == true
      "These are invalid coordinates, please try again"

      "Enter the squares for the cruiser (3 spaces)"
      user_coordinates = array.new
      user_coordinates << gets.chomp
      user_coordinates.split(" ")
    end
      board.place(cruiser, user_coordinates)
  end
