require "json"

require "./color"
require "./type"

module Checkers
  class Piece
    property color : Color
    property type : Type

    def initialize(color, type)
      @color = color
      @type = type
    end

    def self.new_white_man
      self.new(Color::White, Type::Man)
    end

    def self.new_white_king
      self.new(Color::White, Type::King)
    end

    def self.new_black_man
      self.new(Color::Black, Type::Man)
    end

    def self.new_black_king
      self.new(Color::Black, Type::King)
    end

    def rank_step_dir
      if @color.white?
        -1
      else
        1
      end
    end

    def left_step(square)
      square.add(self.rank_step_dir, -1)
    end

    def right_step(square)
      square.add(self.rank_step_dir, 1)
    end

    def white?
      @color.white?
    end

    def black?
      @color.black?
    end

    def man?
      @type.man?
    end

    def king?
      @type.king?
    end

    def opponent?(other)
      self.color != other.color
    end

    def promote
      @type = Type::King
    end

    def to_json(json : JSON::Builder)
      json.string(to_s)
    end

    def to_s(io)
      case @color
      when .white?
        case @type
        when .king?
          io << "K"
        when .man?
          io << "M"
        end
      when .black?
        case @type
        when .king?
          io << "k"
        when .man?
          io << "m"
        end
      end
    end
  end
end
