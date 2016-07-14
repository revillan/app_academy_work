require_relative 'board'

class Tile
  attr_accessor :bombed, :flagged, :revealed

  def initialize(board)
    @bombed = false
    @flagged = false
    @revealed = false
    @value = 0
    @board = board

  end

  def reveal(pos)
    @revealed = true
    neighbor_bomb_count(pos)
    if @bombed
      puts "You got bombed"
      exit
    end
  end

  def flag
    @flagged = !@flagged
  end

  def bomb
    @bombed = true
  end

  def grid
    @board.grid
  end
  def neighbors(pos)
    neighbor_tiles = []
    x, y = pos
    find_range(x).each do |i|
      find_range(y).each do |j|
        next if [i, j] == pos
        neighbor_tiles << @board[[i,j]]
      end
    end
    neighbor_tiles
  end


  def find_range(x)
      if x == 0
        (x..x+1)
      elsif grid.length - 1
        (x-1..x)
      else
        (x-1..x+1)
      end
  end


  def neighbor_bomb_count(pos)
    neighbor_tiles = neighbors(pos)
    count = 0
    neighbor_tiles.each do |tile|
      count += 1 if tile.bombed
    end
    @value = count
    @value
  end

  def to_s
    return "F" if @flagged
    return "*" unless @revealed
    if @value > 0
      @value.to_s
    else
      "_"
    end
  end

end
