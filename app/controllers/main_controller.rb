
class MainController < ApplicationController

  def index
    @groups = [[20,5], [20, 10], [20, 20], [50, 5], [50, 10], [50, 20]]
  end

  def about
  end

  def flow_shop
  end
  
  def do_sleep
    sleep 10
  end
  
  
end

