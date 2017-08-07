require_relative 'cursor.rb'
require 'colorize'
require_relative 'board.rb'


class Display

  attr_accessor :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  PIECES = {
    Rook => "R",
    Knight => "N",
    Bishop => "B",
    Queen => "Q",
    King => "K",
    Pawn => "P",
    NullPiece => "_"
  }

  def render
    print "  "
    (0..7).each { |el| print el.to_s + " "}
    puts ""
    (0..7).each do |row|
      print row.to_s + " "
      board.grid[row].each_with_index do |square, col|
        if @cursor_pos = [row, col]
          print (PIECES[square.class] + " ").color
        else
          print PIECES[square.class] + " "
        end
      end

      puts ""
    end
  end
end
