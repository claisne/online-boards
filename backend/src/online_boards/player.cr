require "./messages/client"
require "./games/*"

alias Client =  Messages::Client
alias Server =  Messages::Server

class Player
  property uid : String
  @socket : HTTP::WebSocket

  property game : Games::Game?

  def initialize(@socket)
    @uid = SecureRandom.urlsafe_base64(8, true)
    LOGGER.debug("Player/initialize uid=#{@uid}")
    send(Server::UidCreated.new(@uid))

    socket.on_message { |msg_json| on_message(msg_json) }
    socket.on_close { |close| on_close }
  end

  def on_message(msg_json)
    begin
      msg = Client.parse(msg_json)
      on_message(msg)
    rescue exception
      LOGGER.error(exception)
    end
  end

  def on_message(msg : Client::GamePlay)
    game = @game
    if game.nil?
      Games::Queue.add(self, msg.size, msg.mode)
    else
      send(Server::GameCreated.new(game))
    end
  end

  def send(msg)
    @socket.send(msg.to_json)
  end

  def on_close
    Games::Queue.remove(self)
  end

  def finalize
    LOGGER.debug("Player/finalize uid=#{@uid}")
  end
end
