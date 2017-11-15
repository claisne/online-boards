module Checkers
  class Piece
    enum Type
      Man
      King
    end

    enum Color
      White
      Black
    end

    property color : Color
    property type : Type

    def initialize(color, type)
      @color = color
      @type = type
    end

    def self.new_white_man
      self.new(Color::Black, Type::Man)
    end

    def self.new_black_king
      self.new(Color::Black, Type::King)
    end

    def self.new_black_man
      self.new(Color::Black, Type::Man)
    end

    def self.new_black_king
      self.new(Color::Black, Type::King)
    end

    def promote
      @type = Type::King
    end

    def to_s(io)
      case @color
      when .white?
        case @type
        when .king?
          io << "⛁"
        when .man?
          io << "⛀"
        end
      when .black?
        case @type
        when .king?
          io << "⛃"
        when .man?
          io << "⛂"
        end
      end
    end
  end
end

