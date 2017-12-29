require "kemal"

require "./logger"
require "./player"
require "./games"

ws "/" do |socket|
  Player.new(socket)
end

error 404 do |env|
  "Not Found."
end

error 500 do |env|
  "Internal Server Error."
end

LOGGER.info("Server listening")

Kemal.config.logging = false
Kemal.config.port = 3001
Kemal.run
