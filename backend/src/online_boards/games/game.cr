require "../logger"
require "../checkers/*"

module Games
  class Game
    JSON.mapping({
      uid: String,
      checkers: Checkers::Board,
    })

    def initialize(size, mode)
      @uid = SecureRandom.urlsafe_base64(8, true)
      @checkers = Checkers::Board.new_starting_position(size)
      LOGGER.debug("Games::Game/initialize with uid=#{@uid}")
    end
  end
end
