class Board
  attr_reader :board, :cells

  def initialize
    @letter_array = []
    @number_array = []
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),}
  end

  def valid_coordinate?(coordinate)
    coordinates = @cells.keys
    coordinates.any? do |keys|
      return true if coordinate == keys
      false
    end
  end

  def valid_placement?(ship, array_of_coordinates)
    if array_of_coordinates.length == ship.length
      coordinates_consecutive(array_of_coordinates)
    else
      return false
    end
  end

  def coordinates_consecutive(array_of_coordinates)
    array_of_coordinates.each do |coordinate|
      @letter_array << coordinate[0]
      @number_array << coordinate[1]
    end

    if letters_consecutive && same_numbers
      @letter_array = []
      @number_array = []
      true
    elsif numbers_consecutive && same_letters
      @letter_array = []
      @number_array = []
      true
    else
      @letter_array = []
      @number_array = []
      false
    end
  end

  def letters_consecutive
    @letter_array.each_cons(2).all? do |letter1, letter2|
      letter2.ord == letter1.ord + 1
    end
  end

  def numbers_consecutive
    @number_array.each_cons(2).all? do |num1, num2|
      num2.to_i == num1.to_i + 1
    end
  end

  def same_letters
    @letter_array.each_cons(2).all? do |letter1, letter2|
      letter1 == letter2
    end
  end

  def same_numbers
    @number_array.each_cons(2).all? do |num1, num2|
      num1 == num2
    end
  end

  def place(ship, array_of_coordinates)

  end

end
