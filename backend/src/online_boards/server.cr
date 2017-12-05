require "kemal"

require "./games"
require "./messages"

SOCKETS = Set(HTTP::WebSocket).new

spawn do
  loop do
    msg = Messages::SocketCount.new(SOCKETS.size)
    SOCKETS.each { |socket| socket.send(msg.to_json) }
    sleep 1.second
  end
end

ws "/" do |socket|
  SOCKETS.add(socket)
  Games.player_connected(socket)

  socket.on_message do |message_json|
    begin
      message = Messages.parse(message_json)
      message.handle(socket)
    rescue exception
      puts exception
    end
  end

  socket.on_close do
    SOCKETS.delete(socket)
    Games.player_disconnected(socket)
  end
end

error 404 do |env|
  "Not Found."
end

error 500 do |env|
  "Internal Server Error."
end

Kemal.config.logging = false
Kemal.config.port = 3001
Kemal.run
