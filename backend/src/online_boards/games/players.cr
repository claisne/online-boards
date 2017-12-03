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
      puts game.to_json
      player_1.send(game.to_json)
      player_2.send(game.to_json)
    end

    def connected(socket)
      if @game_by_player.has_key?(socket)
      end
    end

    def disconnected(socket)
      if @game_by_player.has_key?(socket)
      end
    end
  end

  def self.players
    Players::INSTANCE
  end
end
