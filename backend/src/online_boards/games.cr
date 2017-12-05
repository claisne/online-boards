require "./games/*"

module Games
  QUEUE   = Queue.new
  PLAYERS = Players.new

  def self.play_checkers(size, mode, socket)
    if !PLAYERS.includes?(socket)
      QUEUE.add(size, mode, socket)
    end
  end

  def self.create(size, mode, player_1, player_2)
    game = Game.new(size, mode)
    PLAYERS.add_game(player_1, player_2, game)
  end

  def self.player_connected(socket)
    PLAYERS.connected(socket)
  end

  def self.player_disconnected(socket)
    QUEUE.remove(socket)
    PLAYERS.disconnected(socket)
  end
end
