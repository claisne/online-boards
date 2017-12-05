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

      msg = Messages::GameCreated.new(game)
      socket_1.send(msg.to_json)
      socket_2.send(msg.to_json)
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
