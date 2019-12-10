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
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"

    #added the elsif and else statements
    user_answer = gets.chomp
      if user_answer == "p"
        play
      elsif user_answer == "q"
        start
      else
        puts "Invalid input, please try again."
        start
      end
  end

  def play
    place_computer_ships(@computer_cruiser)
    place_computer_ships(@computer_submarine)
    place_user_ships(@computer_cruiser)
    place_user_ships(@computer_submarine)
  end

  def place_computer_ships(ship)
    puts @computer_board.render

    coordinates = []
    single_coordinate = ""
    ship.length.times do
      single_coordinate = @computer_board.cells.keys.sample
      until @computer_board.valid_coordinate?(single_coordinate)
        single_coordinate = @computer_board.cells.keys.sample
      end
      coordinates << single_coordinate
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
    puts "I have laid my ships on the grid."
    puts "You now need to lay out your ships."
    puts "The Cruiser is three units long and the submarine is two units long."
  end

  def place_user_ships(ship)
    puts @user_board.render

    user_coordinates = []
    until @user_board.valid_placement?(ship, user_coordinates)
      puts "These are invalid coordinates, please try again!"

      puts "Enter the squares for the #{ship} (#{ship.length} spaces)"
      user_coordinates << gets.chomp
      user_coordinates.split(" ")
    end
    @user_board.place(ship, user_coordinates)
    puts @user_board.render

    #added this if statement
    if ship == @user_submarine
      player_done_placing
    end
  end

  #added this method
  def player_done_placing
    puts "I have placed my ships"
    puts "It is your turn"
    take_turn
  end

  def take_turn
    board_display
    puts "Enter the coordinate for your shot"
    coordinates_to_fire_upon = get.chomps

    until @computer_board.valid_coordinate?(coordinates_to_fire_upon)
      puts "Please enter a valid coordinate:"
      coordinates_to_fire_upon = get.chomps
    end
    @computer_board.cells[coordinates_to_fire_upon].fire_upon

    #this is for the computer taking a turn
    coordinates_computer_fires_upon = @computer_board.cells.keys.sample
    until coordinates_computer_fires_upon.fired_upon == false
      coordinates_computer_fires_upon = @computer_board.cells.keys.sample
    end
    @user_board.cells[coordinates_computer_fires_upon].fire_upon

    shot_results(coordinates_to_fire_upon, coordinates_computer_fires_upon)
  end

  def board_display
    puts "=============COMPUTER BOARD============="
    @computer_board.render
    puts "==============PLAYER BOARD=============="
    @user_board.render
  end

  def shot_results(coordinates_to_fire_upon, coordinates_computer_fires_upon)
    if @computer_board.cells[coordinates_to_fire_upon].fired_upon && @computer_board.cells[coordinates_to_fire_upon].ship == nil
      puts "Your shot on #{coordinates_to_fire_upon} was a miss"
    elsif @computer_board.cells[coordinates_to_fire_upon].fired_upon && @computer_board.cells[coordinates_to_fire_upon].ship.sunk
      puts "Your shot on #{coordinates_to_fire_upon} sunk an enemy ship"
    else
      puts "Your shot on #{coordinates_to_fire_upon} hit an enemy ship"
    end

    if @user_board.cells[coordinates_computer_fires_upon].fired_upon && @user_board.cells[coordinates_computer_fires_upon].ship == nil
      puts "My shot on #{coordinates_computer_fires_upon} was a miss"
    elsif @user_board.cells[coordinates_computer_fires_upon].fired_upon && @user_board.cells[coordinates_computer_fires_upon].ship.sunk
      puts "My shot on #{coordinates_computer_fires_upon} sunk an enemy ship"
    else
      puts "My shot on #{coordinates_computer_fires_upon} hit an enemy ship"
    end
  end
end
