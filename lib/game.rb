require './lib/board'
require './lib/ship'
require 'colorize'

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

    @coordinates_to_fire_on = ''
    @coordinates_computer_fires_on = ''
  end

  def get_user_input
    gets.chomp
  end

  def start
    puts "Welcome to BATTLESHIP".cyan
    puts "Enter p to play. Enter q to quit".cyan

    user_answer = get_user_input
      if user_answer.upcase == "P"
        play
      elsif user_answer.upcase == "Q"
        start
      else
        puts "Invalid input, please try again.".cyan
        start
      end
  end

  def play
    place_computer_ships(@computer_cruiser)
    place_computer_ships(@computer_submarine)
    place_user_ships(@user_cruiser)
    place_user_ships(@user_submarine)
  end

  def place_computer_ships(ship)
    coordinates = []
    if @computer_board.valid_placement?(ship, coordinates)
      @computer_board.place(ship, coordinates)
    else
      coordinates = @computer_board.cells.keys.sample(ship.length)
      until @computer_board.valid_placement?(ship, coordinates)
        coordinates = @computer_board.cells.keys.sample(ship.length)
      end
      @computer_board.place(ship, coordinates)
    end

    if ship == @computer_submarine
      computer_done_placing
    end
  end

  def computer_done_placing
    puts "I have laid my ships on the grid.".cyan
    puts "You now need to lay out your ships.".cyan
    puts "The Cruiser is three units long and the submarine is two units long.".cyan
  end

  def place_user_ships(ship)
    puts @user_board.render(true)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)".cyan
    puts "Enter your coordinates in order, and without commas".cyan
    user_coordinates = get_user_input
    user_coordinates_array = user_coordinates.upcase.split(" ")

    until @user_board.valid_placement?(ship, user_coordinates_array)
      puts "These are invalid coordinates, please try again!".cyan
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)".cyan
      puts "Enter your coordinates in order, and without commas".cyan
      user_coordinates = get_user_input
      user_coordinates_array = user_coordinates.upcase.split(" ")
    end
    @user_board.place(ship, user_coordinates_array)

    if ship.name == "Submarine"
      player_done_placing
    end
  end

  def player_done_placing
    puts "I have placed my ships".cyan
    turn
  end

  def turn
    until @user_cruiser.sunk && @user_submarine.sunk || @computer_cruiser.sunk && @computer_submarine.sunk
      board_display
      player_take_turn
      computer_take_turn
      shot_results(@coordinates_to_fire_on, @coordinates_computer_fires_on)
    end
    game_over
  end

  def player_take_turn
    puts "Enter the coordinate for your shot".cyan
    @coordinates_to_fire_on = get_user_input.upcase
    until @computer_board.valid_coordinate?(@coordinates_to_fire_on)
      puts "Please enter a valid coordinate:".cyan
      @coordinates_to_fire_on = get_user_input.upcase
    end
    @computer_board.cells[@coordinates_to_fire_on.upcase].fire_upon
  end

  def computer_take_turn
    @coordinates_computer_fires_on = @computer_board.cells.keys.sample
    until @user_board.cells[@coordinates_computer_fires_on].fired_upon == false
      @coordinates_computer_fires_on = @computer_board.cells.keys.sample
    end
    @user_board.cells[@coordinates_computer_fires_on].fire_upon
  end

  def board_display
    puts "=============COMPUTER BOARD=============".magenta.bold
    puts @computer_board.render
    puts "==============YOUR BOARD==============".magenta.bold
    puts @user_board.render(true)
  end

  def shot_results(coordinates_to_fire_upon, coordinates_computer_fires_upon)
    user_results(coordinates_to_fire_upon)
    computer_results(coordinates_computer_fires_upon)
  end

  def user_results(coordinates_to_fire_upon)
    if @computer_board.cells[coordinates_to_fire_upon].fired_upon && @computer_board.cells[coordinates_to_fire_upon].ship == nil
      puts "Your shot on #{coordinates_to_fire_upon} was a miss".green
    elsif @computer_board.cells[coordinates_to_fire_upon].fired_upon && @computer_board.cells[coordinates_to_fire_upon].ship.sunk
      puts "Your shot on #{coordinates_to_fire_upon} sunk an enemy ship".green
    else
      puts "Your shot on #{coordinates_to_fire_upon} hit an enemy ship".green
    end
  end

  def computer_results(coordinates_computer_fires_upon)
    if @user_board.cells[coordinates_computer_fires_upon].fired_upon && @user_board.cells[coordinates_computer_fires_upon].ship == nil
      puts "My shot on #{coordinates_computer_fires_upon} was a miss".green
    elsif @user_board.cells[coordinates_computer_fires_upon].fired_upon && @user_board.cells[coordinates_computer_fires_upon].ship.sunk
      puts "My shot on #{coordinates_computer_fires_upon} sunk one of your enemy ships".green
    else
      puts "My shot on #{coordinates_computer_fires_upon} hit one of your ships".green
    end
  end

  def game_over
    board_display
    if @user_cruiser.sunk && @user_submarine.sunk
        puts "It appears I have defeated your forces. Better luck next time, rookie".cyan
        new_game
    else @computer_cruiser.sunk && @computer_submarine.sunk
        puts "It appears you have emerged victorious. You may have won the battle, but I'll still win this war.".cyan
        new_game
    end
  end

  def new_game
    puts "Would you like to play again? (y/n)".green
    user_input = get_user_input.upcase
    if user_input == "Y"
      start
    elsif user_input == "N"
      puts "Thanks for playing!".cyan
    else
      puts "Invalid input.".green
      new_game
    end
  end
end
