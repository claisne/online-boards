require "../games"

module Messages
  module Client
    def self.parse(msg_json)
      pull_parser = JSON::PullParser.new(msg_json)
      pull_parser.on_key("type") do
        msg_type = pull_parser.read_string
        return parse_from_type(msg_type, msg_json)
      end

      raise "No message type"
    end

    macro define(definitions)
      {% for definition in definitions %}
      {% name = definition[0] %}
      {% properties = definition[2] %}
      class {{name}}
        JSON.mapping({
          {% for key, value in properties %}
          {{key}}: {{value}},
          {% end %}
        })
      end
      {% end %}

      def self.parse_from_type(msg_type, msg_json)
        case msg_type
        {% for definition in definitions %}
        {% name = definition[0] %}
        {% type = definition[1] %}
        when {{type}}
          {{name}}.from_json(msg_json)
        {% end %}
        else
          raise "Unknown message type"
        end
      end
    end

    define([
      {GamePlay, "GAME_PLAY", {size: Int32, mode: Games::Mode}},
    ])
  end
end
