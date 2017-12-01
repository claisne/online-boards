require "json"
require "../../games"

module Message
  module Checkers
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
end
