module Games
  class Queue
    INSTANCE = new

    def initialize
      @waiting = Hash(Tuple(Int32, Mode), HTTP::WebSocket).new
    end

    def add(size, mode, socket)
      puts "queue::add"
      waiting_socket = @waiting[{size, mode}]?
      if waiting_socket && waiting_socket != socket
        puts "queue::add/creating"
        Games.create(size, mode, socket, waiting_socket)
      else
        puts "queue::add/add_waiting"
        @waiting[{size, mode}] = socket
      end
    end
  end

  def self.queue
    Queue::INSTANCE
  end
end
