require "json"
require "../games"

module Messages
  class Play
    JSON.mapping({
      size: Int32,
      mode: Games::Mode,
    })

    def handle(socket)
      Games.play_checkers(size, mode, socket)
    end
  end
end
