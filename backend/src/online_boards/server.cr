require "kemal"
require "./message"
require "./message/*"

ws "/" do |socket|
  puts "Opening"

  socket.on_message do |message_json|
    message = Message.parse(message_json)
    message.handle(socket)
  end

  socket.on_close do
    puts "Closing"
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
