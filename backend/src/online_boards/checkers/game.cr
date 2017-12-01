module Checkers
  class Game
    @player_1_seconds : Int32
    @player_2_seconds : Int32

    def initialize(size, mode)
      @player_1_seconds = mode.player_seconds
      @player_2_seconds = mode.player_seconds

      @board = Board.new(size)
    end
  end
end
