require './lib/board'
require './lib/ship'

class Game

  attr_reader :computer_board,
              :computer_cruiser,
              :computer_submarine,
              :user_board,
              :user_cruiser,
              :user_submarine

  def initialize
    @computer_board = Board.new()
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @user_board = Board.new()
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
  end

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
    place_computer_ships(@computer_cruiser)
    place_computer_ships(@computer_submarine)
    place_user_ships(@computer_cruiser)
    place_user_ships(@computer_submarine)
  end

  def quit
    start
  end

  def place_computer_ships(ship)
    @computer_board.render

    coordinates = []
    coordinates = @computer_board.cells.keys.sample(ship.length)
    until @computer_board.valid_coordinate?(coordinates)
      coordinates = @computer_board.cells.keys.sample(ship.length)
    end


    if @computer_board.valid_placement?(ship, coordinates)
      @computer_board.place(ship, coordinates)
    else
      coordinates = @computer_board.cells.keys.sample(ship.length)
      until @computer_board.valid_coordinate?(coordinates)
        coordinates = @computer_board.cells.keys.sample(ship.length)
      end
    end

    if ship == @user_submarine
      computer_done_placing
    end
  end

  def computer_done_placing
    "I have laid my ships on the grid."
    "You now need to lay out your ships."
    "The Cruiser is three units long and the submarine is two units long."
  end

  def place_user_ships(ship)
    @user_board.render

    user_coordinates = array.new
    until board.valid_placement?(ship, user_coordinates)
      "These are invalid coordinates, please try again!"

      "Enter the squares for the #{ship} (#{ship.length} spaces)"
      user_coordinates << gets.chomp
      user_coordinates.split(" ")
    end
    @user_board.place(ship, user_coordinates)

    @user_board.render
  end
end
