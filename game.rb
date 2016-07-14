require_relative 'board'

class Minesweeper
  def initialize
    @board = Board.new

  end

  def run
    "Welcome to Minesweeper"
    @board.lay_bombs(9)
    @board.render
    until @board.won?
      play_turn
      @board.render
    end
    'Game Over'
  end

  def play_turn
    answer = get_answer
    pos = get_pos
    if answer == "F"
      @board[pos].flag
    else
      @board[pos].reveal(pos)
    end
  end

  def get_answer
    puts "Reveal a tile or flag a tile? (R or F)"
      answer = gets.chomp.upcase
      until valid_answer?(answer)
        answer = gets.chomp.upcase
      end
      answer
  end

  def get_pos
    puts "What position?"
    pos = gets.chomp.split(",").map(&:to_i)
    until valid_pos?(pos)
      pos = gets.chomp.split(",").map(&:to_i)
    end
    pos
  end

  def valid_answer?(answer)
    answer.upcase == "R" || answer.upcase == "F"
  end

  def valid_pos?(pos)
    pos.all? { |x| x.between?(0, @board.grid.length - 1) } &&
    pos.length == 2
  end

end

if __FILE__ == $PROGRAM_NAME
  Minesweeper.new.run
end
