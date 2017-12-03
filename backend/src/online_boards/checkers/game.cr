require "json"
require "./board"

module Checkers
  class Game
    JSON.mapping({
      player_1_seconds: Int32,
      player_2_seconds: Int32,
      board: Board
    })

    def initialize(size, mode)
      @player_1_seconds = mode.player_seconds
      @player_2_seconds = mode.player_seconds

      @board = Board.new_starting_position(size)
    end
  end
end

