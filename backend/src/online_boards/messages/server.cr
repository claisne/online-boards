require "../games"

module Messages
  module Server
    macro define(name, type, properties = {} of String => Class)
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

    define(UidCreated, "UID_CREATED", {uid: String})

    define(QueueWaiting, "QUEUE_WAITING")
    define(GameCreated, "GAME_CREATED", {game: Games::Game})
    define(GameUpdated, "GAME_UPDATED", {game: Games::Game})
  end
end
