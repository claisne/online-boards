require "../logger"
require "../messages"
require "./mode"

module Games
  class Queue
    def initialize
      @waiting = Hash(Tuple(Int32, Mode), HTTP::WebSocket).new
    end

    def add(size, mode, socket)
      LOGGER.debug("Games::Queue/add")
      waiting_socket = @waiting[{size, mode}]?
      if waiting_socket && waiting_socket != socket
        LOGGER.debug("Games::Queue/add create")
        Games.create(size, mode, socket, waiting_socket)
      else
        LOGGER.debug("Games::Queue/add waiting")
        @waiting[{size, mode}] = socket
        msg = Messages::QueueWaiting.new()
        socket.send(msg.to_json)
      end
    end

    def remove(socket)
      @waiting.delete_if { |_, waiting_socket| waiting_socket == socket }
    end
  end
end
