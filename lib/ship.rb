class Ship

  attr_reader :name, :length
  attr_accessor :health, :sunk

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    @sunk = false
  end

  def sunk?
    @sunk
  end

  def hit
    @health -= 1
    if @health == 0
      @sunk = true
    end
  end
end
