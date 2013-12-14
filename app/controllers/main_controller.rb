
class MainController < ApplicationController
  
  include LoggerHelper

  def index
    @groups = [[20,5], [20, 10], [20, 20], [50, 5], [50, 10], [50, 20]]
    
    worker = SingleThreadWorker.new
    for i in 1..5
      worker.post do
        sleep 10
        puts "foo"
      end
    end
  end

  def problem
  end

  def algorithm
  end
  
  def webapp
  end

  def about
  end

  def contact
  end

end

