require_relative "board.rb"

class Piece
  attr_accessor :position, :color

  def initialize(pos, color)
    @position = pos
    @color = color
  end

  def update_pos(pos)
    @position = pos
  end

  def moves

  end

  def valid_move?(pos)
  end

end

module SlidingPiece

  def move
    array = []

    move_dirs = move_dir
    until move_dirs.empty?
      move_dirs.each_with_index do |dir, idx|
        pos = [(position.first + move.first), (position.last + move.last)]
        if !Board.in_bounds?(pos) || board[pos].color == color
          move_dirs.delete(dir)
        elsif board[pos].color != color
          move_dirs.delete(dir)
          array << pos
        else
          array << pos
          move_dirs[idx] = [dir.first + 1, dir.last + 1]
        end
      end
    end

    array
  end

  # def self.in_bounds?(pos)
  #   return true if (0..7).include?(pos.first) && (0..7).include?(pos.last)
  #   false
  # end

end

module SteppingPiece

  def moves
    MOVE_ARR.map do |move|
      [(position.first + move.first), (position.last + move.last)]
    end
  end
end

class NullPiece < Piece

  def initialize

  end

end

class Bishop < Piece

  def move_dir
    [[1,1], [-1,-1], [1,-1], [-1,1]]
    [x,y]
  end

end

class Rook < Piece

  def move_dir
    [[0,1], [0, -1], [1, 0], [-1, 0]]
  end
end

class Queen < Piece

  def move_dir
    [[1,1], [-1,-1], [1,-1], [-1,1], [0,1], [0, -1], [1, 0], [-1, 0]]
  end
end

class Knight < Piece
  MOVE_ARR = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2],
              [1, -2], [-1, 2], [-1, -2]].freeze

  include SteppingPiece
end

class King < Piece
  MOVE_ARR = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1],
              [-1, 0], [-1, 1], [-1, -1]].freeze
  include SteppingPiece

end

class Pawn < Piece
end
