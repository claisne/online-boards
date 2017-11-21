require "json"
require "./client"
require "./games/*"

module Message
  class PlayCheckers < Client
    JSON.mapping({
      size: Int32,
      mode: String
    })

    def handle(socket)
      if Games.players.includes?(socket)
      else
        Games.queue.add(socket)
      end
    end
  end
end