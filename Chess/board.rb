require_relative "piece.rb"

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance } }
    add_pieces
  end

  def move_piece(start_pos, end_pos)
    piece = grid[start_pos]
    raise StandardError if piece.is_a?(NullPiece)
    raise StandardError unless piece.valid_move?(end_pos)

    grid[start_pos] = NullPiece.new
    grid[end_pos] = piece
    piece.update_pos(end_pos)
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def add_pieces
    (0..7).each do |col|
      self[[1, col]] = Pawn.new([1, col], :black, self)
      self[[6, col]] = Pawn.new([6, col], :white, self)
    end

    self[[0, 0]] = Rook.new([0, 0], :black, self)
    self[[0, 1]] = Knight.new([0, 1], :black, self)
    self[[0, 2]] = Bishop.new([0, 2], :black, self)
    self[[0, 3]] = Queen.new([0, 3], :black, self)
    self[[0, 4]] = King.new([0, 4], :black, self)
    self[[0, 5]] = Bishop.new([0, 5], :black, self)
    self[[0, 6]] = Knight.new([0, 6], :black, self)
    self[[0, 7]] = Rook.new([0, 7], :black, self)

    self[[7, 0]] = Rook.new([7, 0], :white, self)
    self[[7, 1]] = Knight.new([7, 1], :white, self)
    self[[7, 2]] = Bishop.new([7, 2], :white, self)
    self[[7, 3]] = Queen.new([7, 3], :white, self)
    self[[7, 4]] = King.new([7, 4], :white, self)
    self[[7, 5]] = Bishop.new([7, 5], :white, self)
    self[[7, 6]] = Knight.new([7, 6], :white, self)
    self[[7, 7]] = Rook.new([7, 7], :white, self)
  end

  def self.in_bounds?(pos)
    return true if (0..7).cover?(pos.first) && (0..7).cover?(pos.last)
    false
  end

end
