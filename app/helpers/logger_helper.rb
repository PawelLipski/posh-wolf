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

  class Logger

    include Mongo

    def initialize
      user = ENV['POSH_WOLF_MONGO_USER']
      passwd = ENV['POSH_WOLF_MONGO_PASSWD']
      puts "#{user} #{passwd}"
      if user and passwd
        uri = "mongodb://#{user}:#{passwd}@ds061158.mongolab.com:61158/posh-wolf-logs"
        @mongo_client = MongoClient.from_uri(uri)
        @db = @mongo_client.db("posh-wolf-logs")
        @coll = @db["webapp-logs"]

        puts @coll
      end
    end

  end

end

