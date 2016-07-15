require_relative 'board'
require 'byebug'

class Tile
  attr_accessor :bombed, :flagged, :revealed, :position, :value

  def initialize(board)
    @bombed = false
    @flagged = false
    @revealed = false
    @value = 0
    @board = board
    @position = []

  end

  def reveal(pos)
    @revealed = true
    neighbor_bomb_count(pos)
    cluster(pos) if @value == 0
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

  def cluster(pos)
    # debugger
    return if neighbors(pos).any? { |tile| tile.bombed}
    if neighbors(pos).none? { |tile| tile.bombed}
      not_revealed = neighbors(pos).reject{ |tile| tile.revealed}
      not_revealed.each do |tile|
        tile.reveal(pos)
        cluster(tile.position)
      end
    end
  end
    # # queue = [pos]
    # current = 0
    # until current == queue.length
    #   neighbors(queue[current]).each do |neighbor|
    #     queue << neighbor unless queue.include?(neighbor)
    #   end
    #   adjacent = @board[queue[current]]
    #   adjacent.reveal(queue[current]) unless adjacent.bombed
    #   current += 1
    #   cluster(queue[current, queue])
    # end

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
    count
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
