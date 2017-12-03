require "./games/*"

module Games
  def self.play_checkers(size, mode, socket)
    puts "games::play_checkers"
    if !players.includes?(socket)
      queue.add(size, mode, socket)
    end
  end

  def self.create(size, mode, player_1, player_2)
    puts "games::create"
    game = Checkers::Game.new(size, mode)
    players.add_game(player_1, player_2, game)
  end

  def self.player_connected(socket)
  end

  def self.player_disconnected(socket)
    queue.remove(socket)
    players.disconnected(socket)
  end
end
