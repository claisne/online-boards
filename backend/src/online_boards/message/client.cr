module Message
  abstract class Client
    abstract def handle(socket)
  end
end