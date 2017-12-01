module Games
  enum Mode
    Bullet
    Blitz
    Classic

    def player_seconds
      case self
      when Bullet
        60
      when Blitz
        60 * 5
      when Classic
        60 * 10
      else
        raise "Unreachable"
      end
    end
  end
end
