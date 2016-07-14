require_relative 'tile'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(9){Array.new(9){Tile.new(self)}}
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, mark)
    x, y = pos
    @grid[x][y] = mark
  end

  def lay_bombs(bomb_num)
    bombs_layed = 0
    while bombs_layed < bomb_num
      pos = get_bomb_pos
      until !self[pos].bombed
        pos = get_bomb_pos
      end
      self[pos].bombed = true
      bombs_layed += 1
    end
  end

  def get_bomb_pos
    [rand(@grid.length), rand(@grid.length)]
  end

  def won?
    @grid.all? do |row|
      row.all? do |tile|
        if @bombed == false
          @revealed
        end
      end
    end
  end

  def render
    @grid.each do |row|
      this_row = []
      row.each do |tile|
        this_row << tile.to_s
      end
      puts this_row.join(" ")
    end
  end

end
