require "./game"

module Games
  class Players
    def initialize
      @game_by_socket = Hash(HTTP::WebSocket, Game).new
    end

    def includes?(socket)
      @game_by_socket.has_key?(socket)
    end

    def add_game(socket_1, socket_2, game)
      @game_by_socket[socket_1] = game
      @game_by_socket[socket_2] = game
    end

    def connected(socket)
      if @game_by_socket.has_key?(socket)
      end
    end

    def disconnected(socket)
      if @game_by_socket.has_key?(socket)
      end
    end
  end
end
