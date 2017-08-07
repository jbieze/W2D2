class Piece
  attr_accessor :position, :color

  def initialize(pos, color)
    @position = pos
    @color = color
  end

  def update_pos(pos)
    @position = pos
  end

  def valid_move?(pos)
  end

end

class NullPiece < Piece

  def initialize

  end

end

class Bishop < Piece
end

class Rook < Piece
end

class Queen < Piece
end

class Knight < Piece
end

class King < Piece
end

class Pawn < Piece
end
