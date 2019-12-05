class Board
  attr_reader :board, :cells

  def initialize()
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
    if array_of_coordinates == ship.length
      return true
    else
      return false
    end

  #coordinates_consecutive(array_of_coordinates)

  end

  # def coordinates_consecutive(array_of_coordinates)
  #   letter_array = []
  #   number_array = []
  #   array_of_coordinates.each do |coordinate|
  #     letter_array << coordinate.first
  #     number_array << coordinate.last
  #
  #   end
  # end
end
