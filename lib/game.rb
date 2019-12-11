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
    puts "I have laid my ships on the grid."
    puts "You now need to lay out your ships."
    puts "The Cruiser is three units long and the submarine is two units long."
  end

  def place_user_ships(ship)
    puts @user_board.render(true)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)"
    puts "Enter your coordinates in order, and without commas"
    user_coordinates = gets.chomp
    user_coordinates_array = user_coordinates.split(" ")

    until @user_board.valid_placement?(ship, user_coordinates_array)
      puts "These are invalid coordinates, please try again!"

      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)"
      user_coordinates = gets.chomp
      user_coordinates_array = user_coordinates.split(" ")
    end
    @user_board.place(ship, user_coordinates_array)

    if ship.name == "Submarine"
      player_done_placing
    end
  end

  def player_done_placing
    puts "I have placed my ships"
    puts "It is your turn"
    take_turn
  end

  def take_turn
    until @user_cruiser.sunk && @user_submarine.sunk || @computer_cruiser.sunk && @computer_submarine.sunk
      board_display
      puts "Enter the coordinate for your shot"
      coordinates_to_fire_upon = gets.chomp

      until @computer_board.valid_coordinate?(coordinates_to_fire_upon)
        puts "Please enter a valid coordinate:"
        coordinates_to_fire_upon = gets.chomp
      end
      @computer_board.cells[coordinates_to_fire_upon].fire_upon

      #this is for the computer taking a turn
      coordinates_computer_fires_upon = @computer_board.cells.keys.sample
      until @user_board.cells[coordinates_computer_fires_upon].fired_upon == false
        coordinates_computer_fires_upon = @computer_board.cells.keys.sample
      end
      @user_board.cells[coordinates_computer_fires_upon].fire_upon

      shot_results(coordinates_to_fire_upon, coordinates_computer_fires_upon)

      end
    game_over
  end

  def board_display
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @user_board.render(true)
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
      puts "My shot on #{coordinates_computer_fires_upon} sunk one of your enemy ships"
    else
      puts "My shot on #{coordinates_computer_fires_upon} hit one of your ships"
    end

    def take_turn
      board_display
      puts "Enter the coordinate for your shot"
      coordinates_to_fire_upon = gets.chomp

      until @computer_board.valid_coordinate?(coordinates_to_fire_upon)
        puts "Please enter a valid coordinate:"
        coordinates_to_fire_upon = gets.chomp
      end
      @computer_board.cells[coordinates_to_fire_upon].fire_upon

      #this is for the computer taking a turn
      coordinates_computer_fires_upon = @computer_board.cells.keys.sample
      until @user_board.cells[coordinates_computer_fires_upon].fired_upon == false
        coordinates_computer_fires_upon = @computer_board.cells.keys.sample
      end
      @user_board.cells[coordinates_computer_fires_upon].fire_upon

      shot_results(coordinates_to_fire_upon, coordinates_computer_fires_upon)
    end
  end

    def game_over
      if @user_cruiser.sunk && @user_submarine.sunk
          puts "It appears I have defeated your forces. Better luck next time, rookie"
      else @computer_cruiser.sunk && @computer_submarine.sunk
          puts "It appears you have emerged victorious. You may have won the battle, but I'll still win this war."
      end
    end
end
