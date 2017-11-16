module Checkers
  struct Square
    property rank : Int32
    property file : Int32

    def initialize(rank, file)
      @rank = rank
      @file = file
    end

    def add(rank, file)
      Square.new(self.rank + rank, self.file + file)
    end
  end
end


