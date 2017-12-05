module Messages
  class SocketCount
    JSON.mapping({
      type:  String,
      count: Int32,
    })

    def initialize(@count)
      @type = "SOCKET_COUNT"
    end
  end
end
