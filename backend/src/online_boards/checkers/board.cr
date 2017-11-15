require "./piece"

module Checkers
  class Board
    @size : Int32
    @board : Array(Array(Piece?))

    def initialize(size)
      @size = size

      @board = Array.new(@size) do |i|
        Array.new(@size) do |j|
          if i%2 != j%2
            if i < (size / 2) - 1
              Piece.new_black_man()
            elsif i > (size / 2)
              Piece.new_white_man()
            end
          end
        end
      end
    end

    def to_s(io)
      @board.each do |line|
        line.each do |piece|
          if piece
            io << piece
          end
          io << "."
        end
        io << '\n'
      end
    end
  end
end

