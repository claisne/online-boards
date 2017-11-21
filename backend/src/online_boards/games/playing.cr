module Games
  class Players
    INSTANCE = Playing.new

    def initialize
    end
  end

  def self.Players
    Players::INSTANCE
  end
end
