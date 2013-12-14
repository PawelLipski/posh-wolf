module LoggerHelper

  class SingleThreadWorker

    def initialize
      @queue = Queue.new
      @thread = Thread.new do
        catch(:quit) do
          loop do
            @queue.pop.call
          end
        end
      end
    end

    def post(&task)
      @queue << task
    end

    def finish
      post { throw :quit }
      @thread.join 
    end

  end

end

