require_relative 'cursor.rb'
require 'colorize'
require_relative 'board.rb'
require 'byebug'


class Display

  attr_accessor :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  PIECES = {
    [Rook, :white] => "\u2656",
    [Knight, :white] => "\u2658",
    [Bishop, :white] => "\u2657",
    [Queen, :white] => "\u2655",
    [King, :white] => "\u2654",
    [Pawn, :white] => "\u2659",
    [Rook, :black] => "\u265C",
    [Knight, :black] => "\u265E",
    [Bishop, :black] => "\u265D",
    [Queen, :black] => "\u265B",
    [King, :black] => "\u265A",
    [Pawn, :black] => "\u265F",
    [NullPiece, nil] => " "
  }

  def hovered?(pos)
    cursor.cursor_pos == pos
  end

  def render
    print "  "
    (0..7).each { |el| print el.to_s + " " }
    puts ""
    (0..7).each do |row|
      print row.to_s + " "
      board.grid[row].each_with_index do |piece, col|
        pos = [row, col]

        if cursor.selected && hovered?(pos)
          print (PIECES[[piece.class, piece.color]] + " ")
          .colorize(background: :red)

        elsif board.selected_pos.include?(pos)
          print (PIECES[[piece.class, piece.color]] + " ")
          .colorize(color: :blue, background: :red)

        elsif hovered?(pos)
          print (PIECES[[piece.class, piece.color]] + " ")
          .colorize(color: :blue, background: :yellow)

        elsif (row + col).even?
          print (PIECES[[piece.class, piece.color]] + " ")
          .colorize(color: :black, background: :white)

        else
          print (PIECES[[piece.class, piece.color]] + " ")
          .colorize(color: :black, background: :gray)
        end
      end
      puts ""
    end
    nil
  end

  def get_move
    while board.selected_pos.length < 2
      render
      cursor.get_input
      system("clear")
    end

    board.move_piece(board.selected_pos.first, board.selected_pos.last)
    board.selected_pos = []
    render
  end

end
