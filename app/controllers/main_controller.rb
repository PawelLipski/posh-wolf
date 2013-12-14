
class MainController < ApplicationController
  
  include LoggerHelper

  def index
    @groups = [[20,5], [20, 10], [20, 20], [50, 5], [50, 10], [50, 20]]
  
    Logger.new
  end

  def problem
  end

  def algorithm
  end
  
  def system
  end

  def about
  end

  def contact
  end

end

