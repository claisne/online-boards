require "../checkers/*"

module Games
  class Game
    JSON.mapping({
      player_1_seconds: Int32,
      player_2_seconds: Int32,
      checkers:         Checkers::Board,
    })

    def initialize(size, mode)
      @player_1_seconds = mode.player_seconds
      @player_2_seconds = mode.player_seconds

      @checkers = Checkers::Board.new_starting_position(size)
    end
  end
end
