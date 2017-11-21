module Games
  class Queue
    INSTANCE = Queue.new

    def initialize
    end
  end

  def self.queue
    Queue::INSTANCE
  end
end