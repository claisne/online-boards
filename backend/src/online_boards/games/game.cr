require "json"

require "../logger"
require "../checkers/*"

require "./mode"

module Games
  class Game
    @uid : String
    @mode : Mode

    @turn_player : Player
    @white_player : Player
    @black_player : Player

    @board : Checkers::Board

    def initialize(player_1, player_2, size, mode)
      @mode = mode

      @uid = SecureRandom.urlsafe_base64(8, true)
      LOGGER.debug("Games::Game/initialize uid=#{@uid}")

      @turn_player = player_1

      @white_player = player_1
      @black_player = player_2

      @board = Checkers::Board.new_starting_position(size)
    end

    def move(player, move)
      LOGGER.debug("Games::Game/move")

      return if player != @turn_player
      return unless @checkers.legal_move?(move)

      @turn = tuen_next()
      @checkers.apply_move(move)

      LOGGER.debug("Games::Game/move updated")
    end

    def turn_color
      if @turn_player == @white_player
        Checkers::Color::White
      else
        Checkers::Color::Black
      end
    end

    def turn_next
      if @turn_player == player_1
        player_2
      else
        player_1
      end
    end

    def to_json(json : JSON::Builder)
      json.object do
        json.field("uid", @uid)
        json.field("white", @white_player.uid)
        json.field("turn", @turn_player.uid)
        json.field("board") { @board.to_json(json) }
        json.field("moves") { @board.moves(turn_color).to_json(json) }
      end
    end

    def finalize
      LOGGER.debug("Games::Game/finalize uid=#{@uid}")
    end
  end
end
