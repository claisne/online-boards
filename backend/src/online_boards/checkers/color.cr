module Checkers
  enum Color
    White
    Black

    def opponent
      if white?
        Black
      else
        White
      end
    end
  end
end
