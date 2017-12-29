require "./games/*"
require "./messages/server"

module Games
  def self.create(player_1, player_2, size, mode)
    game = Game.new(player_1, player_2, size, mode)
    player_1.game = game
    player_2.game = game

    msg = Server::GameCreated.new(game)
    player_1.send(msg)
    player_2.send(msg)
  end
end
