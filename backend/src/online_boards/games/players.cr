require "../checkers/*"

module Games
  class Players
    INSTANCE = new

    def initialize
      @game_by_player = Hash(HTTP::WebSocket, Checkers::Game).new
    end

    def includes?(socket)
      @game_by_player.has_key?(socket)
    end

    def add_game(player_1, player_2, game)
      @game_by_player[player_1] = game
      @game_by_player[player_2] = game
    end
  end

  def self.players
    Players::INSTANCE
  end
end