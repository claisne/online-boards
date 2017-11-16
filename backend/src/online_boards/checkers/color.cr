module Checkers
  enum Color
    White
    Black

    def opponent
      if self.white?
        Black
      else
        White
      end
    end
  end
end
