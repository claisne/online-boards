module Games
  enum Mode
    Bullet
    Blitz
    Classic

    def seconds_span
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

    def time_span
      Time::Span.new(0, 0, seconds_span)
    end
  end
end
