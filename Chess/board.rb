require_relative "piece.rb"

class Board

  attr_accessor :grid, :selected_pos

  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance } }
    @selected_pos = []
    add_pieces
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]
    raise StandardError if piece.is_a?(NullPiece)
    raise StandardError unless piece.valid_move?(end_pos)

    self[start_pos] = NullPiece.instance
    self[end_pos] = piece
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

  def get_side_pieces(color)
    array = []

    (0..7).each do |i|
      (0..7).each do |i2|
        pos = [i, i2]
        piece = self[pos]
        array << pos if !piece.is_a?(NullPiece) && piece.color == color
      end
    end

    array
  end

  def in_check?(color)
    if color == :white
      opp_color = :black
    else
      opp_color = :white
    end
    #get king pos
    #check all valid moves of other PIECES
    #if any of those moves are on king, return true
    king_pos = get_piece_pos(King, color)
    opp_piece_positions = get_side_pieces(opp_color)
    opp_valid_moves = []
    opp_piece_positions.each do |pos|
      piece = self[pos]
      opp_valid_moves += piece.moves
    end
    opp_valid_moves.include?(king_pos)
  end

  def get_piece_pos(type, color)
    (0..7).each do |i|
      (0..7).each do |i2|
        pos = [i, i2]
        piece = self[pos]
        return pos if piece.is_a?(type) && piece.color == color
      end
    end

  end

end
