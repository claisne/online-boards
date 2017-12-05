require "json"

require "./messages/*"

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
end
