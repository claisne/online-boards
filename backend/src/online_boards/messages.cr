require "json"

require "./messages/*"
require "./games/game"

module Messages
  def self.parse(message_json)
    pull_parser = JSON::PullParser.new(message_json)
    pull_parser.on_key("type") do
      message_type = pull_parser.read_string
      return parse_from_type(message_type, message_json)
    end

    raise "No message type"
  end

  def self.parse_from_type(message_type, message_json)
    case message_type
    when "PLAY_CHECKERS"
      Play.from_json(message_json)
    else
      raise "Unknown message type"
    end
  end

  macro define_server(name, type, properties = {} of String => Class)
    class {{name}}
      JSON.mapping({
        type: String,
        {% for key, value in properties %}
        {{key}}: {{value}},
        {% end %}
      })

      def initialize(
        {% for key, value in properties %}
          @{{key}},
        {% end %}
      )
        @type = {{type}}
      end
    end
  end

  define_server(SocketCount, "SOCKET_COUNT", { count: Int32 })
  define_server(QueueWaiting, "QUEUE_WAITING")
  define_server(GameCreated, "GAME_CREATED", { game: Games::Game })
end
