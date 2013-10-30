include Mongo

class MainController < ApplicationController
  def index
    @text = "Hello"
    mongo_client = MongoClient.from_uri("mongodb://hgt:hgt123@ds041178.mongolab.com:41178/hgtdb")
    db = mongo_client.db("hgtdb")
    @coll_names = db.collection_names
    #.each { |name| puts name }
  end
end
