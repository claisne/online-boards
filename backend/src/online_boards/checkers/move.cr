require "json"
require "./square"

module Checkers
  class Move
    property squares : Array(Square)
    property captures : Set(Square)

    def initialize(@squares = Array(Square).new, @captures = Set(Square).new)
    end

    def self.new_explore(start)
      move = self.new
      move.squares << start
      move
    end

    def self.new_step(start, end_step)
      move = self.new
      move.squares << start << end_step
      move
    end

    def add_capture(end_square, capture_square)
      @squares << end_square
      @captures << capture_square
    end

    def start_square
      @squares[0]
    end

    def end_square
      @squares[-1]
    end

    def clone
      Move.new(@squares.dup, @captures.dup)
    end

    def to_json(json : JSON::Builder)
      json.object do
        json.field("squares") { @squares.to_json(json) }
        json.field("captures") { @captures.to_json(json) }
      end
    end
  end
end
