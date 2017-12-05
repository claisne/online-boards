require "../games"

module Messages
  class GameCreated
    JSON.mapping({
      type: String,
      game: Games::Game,
    })

    def initialize(@game)
      @type = "GAME_CREATED"
    end
  end
end
