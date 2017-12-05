require "./mode"

module Games
  class Queue
    def initialize
      @waiting = Hash(Tuple(Int32, Mode), HTTP::WebSocket).new
    end

    def add(size, mode, socket)
      waiting_socket = @waiting[{size, mode}]?
      if waiting_socket && waiting_socket != socket
        Games.create(size, mode, socket, waiting_socket)
      else
        @waiting[{size, mode}] = socket
      end
    end

    def remove(socket)
      @waiting.delete_if { |_, waiting_socket| waiting_socket == socket }
    end
  end
end
