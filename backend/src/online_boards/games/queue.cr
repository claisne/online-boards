require "../logger"
require "../messages/server"

require "./mode"

module Games
  class Queue
    @@waiting = Hash(Tuple(Int32, Mode), Player).new

    def self.add(player, size, mode)
      LOGGER.debug("Games::Queue/add")
      waiting_player = @@waiting[{size, mode}]?
      if !waiting_player.nil? && waiting_player != player
        LOGGER.debug("Games::Queue/add create")
        @@waiting.delete({size, mode})
        Games.create(player, waiting_player, size, mode)
      else
        LOGGER.debug("Games::Queue/add waiting")
        @@waiting[{size, mode}] = player
        player.send(Messages::Server::QueueWaiting.new)
      end
    end

    def self.remove(player)
      @@waiting.delete_if { |_, waiting_player| waiting_player == player }
      LOGGER.debug("Games::Queue/disconnected", @@waiting.size)
    end
  end
end
