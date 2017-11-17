require "./square"
require "./move"
require "./piece"

module Checkers
  class Board
    @size : Int32
    @board : Hash(Square, Piece)

    def initialize(@size = 10, @board = Hash(Square, Piece).new)
    end

    def self.new_starting_position(size = 10)
      board = new(size)
      board.set_starting_board
      board
    end

    def set_starting_board
      (0...@size).each do |rank|
        (0...@size).each do |file|
          if rank % 2 != file % 2
            if rank < (@size / 2) - 1
              square = Square.new(rank, file)
              piece = Piece.new_black_man
              @board[square] = piece
            elsif rank > (@size / 2)
              square = Square.new(rank, file)
              piece = Piece.new_white_man
              @board[square] = piece
            end
          end
        end
      end
    end

    def set_piece(piece, square)
      @board[square] = piece
    end

    def piece_at(square)
      @board[square]?
    end

    def legal_square?(square)
      square.rank >= 0 && square.rank < @size && square.file >= 0 && square.file < @size
    end

    def empty_square?(square)
      !@board.has_key?(square)
    end

    def legal_and_empty_square?(square)
      legal_square?(square) && empty_square?(square)
    end

    def legal_and_opponent_square?(square, piece)
      other_piece = piece_at(square)
      legal_square?(square) && other_piece && piece.opponent?(other_piece)
    end

    def promotion_square?(square, piece)
      if piece.white?
        square.rank == 0
      else
        square.rank == @size - 1
      end
    end

    def apply_move(move)
      piece = @board.delete(move.start_square)
      if piece
        piece.promote if self.promotion_square?(move.end_square, piece)
        @board[move.end_square] = piece
      end
      move.captures.each do |capture_square|
        @board.delete(capture_square)
      end
    end

    def moves(color)
      captures = Array(Move).new
      steps = Array(Move).new

      @board.each do |square, piece|
        if piece.color == color
          captures.concat(self.piece_captures(piece, square))
          if captures.empty?
            steps.concat(self.piece_steps(piece, square))
          end
        end
      end

      if captures.empty?
        steps
      else
        captures_sizes = captures.map { |move| move.captures.size }
        captures_sizes_max = captures_sizes.max
        captures.select do |move|
          move.captures.size == captures_sizes_max
        end
      end
    end

    def piece_captures(piece, square)
      captures = Array(Move).new

      explore = Array(Move).new
      explore << Move.new_explore(square)

      while !explore.empty?
        move = explore.pop
        explored = true

        {-1, 1}.each do |rank_dir|
          {-1, 1}.each do |file_dir|
            capture_square = move.end_square.add(rank_dir, file_dir)
            if piece.king?
              while legal_and_empty_square?(capture_square)
                capture_square = capture_square.add(rank_dir, file_dir)
              end
            end
            if legal_and_opponent_square?(capture_square, piece)
              if !move.captures.includes?(capture_square)
                end_square = capture_square.add(rank_dir, file_dir)
                while legal_and_empty_square?(end_square)
                  move = move.clone
                  move.add_capture(end_square, capture_square)
                  explore << move
                  explored = false
                  end_square = end_square.add(rank_dir, file_dir)
                end
              end
            end
          end
        end

        if explored && move.squares.size > 1
          captures << move
        end
      end

      captures
    end

    def piece_steps(piece, square)
      end_squares = Array(Square).new

      if piece.man?
        man_steps(piece, square, end_squares)
      else
        king_steps(piece, square, end_squares)
      end

      end_squares.map do |end_square|
        Move.new_step(square, end_square)
      end
    end

    def man_steps(piece, square, end_squares)
      left_step = piece.left_step(square)
      right_step = piece.right_step(square)

      if legal_and_empty_square?(left_step)
        end_squares << left_step
      end

      if legal_and_empty_square?(right_step)
        end_squares << right_step
      end
    end

    def king_steps(piece, square, end_squares)
      {-1, 1}.each do |rank_dir|
        {-1, 1}.each do |file_dir|
          end_square = square.add(rank_dir, file_dir)
          while legal_and_empty_square?(end_square)
            end_squares << end_square
            end_square = end_square.add(rank_dir, file_dir)
          end
        end
      end
    end

    def to_s(io)
      (0...@size).each do |rank|
        io << rank << "|"
        (0...@size).each do |file|
          square = Square.new(rank, file)
          if @board[square]?
            io << @board[square]
          else
            io << "."
          end
        end
        io << "\n"
      end

      io << "  "
      (0...@size).each do |file|
        io << "-"
      end
      io << "\n"

      io << "  "
      (0...@size).each do |file|
        io << file
      end
    end
  end
end
