require "spec"
require "../../../src/online_boards/checkers/*"

alias Board = Checkers::Board
alias Piece = Checkers::Piece
alias Color = Checkers::Color
alias Square = Checkers::Square

describe Board do
  describe "#moves" do
    it "generates the correct moves (turkish coup)" do
      board = Board.new(10)
      board.set_piece(Piece.new_black_king, Square.new(6, 9))
      board.set_piece(Piece.new_white_man, Square.new(5, 8))
      board.set_piece(Piece.new_white_man, Square.new(5, 6))
      board.set_piece(Piece.new_white_man, Square.new(4, 5))
      board.set_piece(Piece.new_white_man, Square.new(7, 6))
      board.set_piece(Piece.new_white_man, Square.new(7, 4))

      moves = board.moves(Color::Black)
      moves.size.should eq 1
      move = moves[0]
      (move.captures == Set{
        Square.new(5, 8),
        Square.new(4, 5),
        Square.new(7, 6),
        Square.new(7, 4),
      }).should be_true
    end
  end
end
