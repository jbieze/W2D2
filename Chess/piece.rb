require_relative "board.rb"
require "singleton"

class Piece
  attr_accessor :position, :color, :board

  def initialize(pos, color, board)
    @board = board
    @position = pos
    @color = color
  end

  def update_pos(pos)
    @position = pos
  end

  def valid_move?(pos)
    moves.include?(pos)
  end

end

module SlidingPiece

  def moves
    array = []

    move_dir.each do |vector|
      array += one_direction(vector)
    end

    array
  end

  def one_direction(vector)
    array = []
    new_pos = position

    while true
      pos = array_addition(vector, new_pos)

      if !Board.in_bounds?(pos) || board[pos].color == color
        puts "Hit barrier!"
        break
      elsif board[pos].color != color && !board[pos].is_a?(NullPiece)
        puts "Hit opponent piece!"
        array << pos
        break
      else
        puts "Hit empty square"
        array << pos
        new_pos = pos
      end
    end

    array.sort
  end

  def array_addition(arr1, arr2)
    arr = []
    arr1.each_with_index do |el, idx|
      arr << el + arr2[idx]
    end
    arr
  end

end

module SteppingPiece

  def moves
    move_arr.map do |move|
      [(position.first + move.first), (position.last + move.last)]
    end
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
    @color = nil
  end

end

class Bishop < Piece
  include SlidingPiece

  def move_dir
    [[1, 1], [-1, -1 ], [1, -1 ], [-1, 1]]
  end

end

class Rook < Piece
  include SlidingPiece

  def move_dir
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end
end

class Queen < Piece
  include SlidingPiece

  def move_dir
    [[1, 1], [-1, -1], [1, -1], [-1, 1], [0, 1], [0, -1], [1, 0], [-1, 0]]
  end
end

class Knight < Piece
  def move_arr
     [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
  end

  include SteppingPiece
end

class King < Piece
  def move_arr
    [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [-1, 0], [-1, 1], [-1, -1]]
  end
  include SteppingPiece

end

class Pawn < Piece
end
