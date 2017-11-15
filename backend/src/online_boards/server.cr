require "kemal"

Kemal.config.logging = false

get "/" do |env|
  "Hello"
end

ws "/" do |socket|
  uuid = SecureRandom.urlsafe_base64(8, true)

  puts "Opened"

  socket.on_message do |message|
    puts message
  end

  socket.on_close do
    puts "Closed"
  end
end

error 404 do |env|
  "Not Found."
end

error 500 do |env|
  "Internal Server Error."
end

Kemal.run

