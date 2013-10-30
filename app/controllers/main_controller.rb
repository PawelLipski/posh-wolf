include Mongo

class MainController < ApplicationController
  def index
    @text = "Hello"
    mongo_client = MongoClient.from_uri("mongodb://hgt:hgt123@ds041178.mongolab.com:41178/hgtdb")
    db = mongo_client.db("hgtdb")
    
    coll = db["flow-shop-test-cases"]
    doc = {"name" => "MongoDB", "type" => "database", "count" => 1, "info" => {"x" => 203, "y" => '102'}}
    id = coll.insert(doc)

    @coll_names = db.collection_names
    @coll = coll.find.to_a
    #.each { |name| puts name }
  end

  def new_test_case
    @url = params[:url]
    @name = params[:name]

    mongo_client = MongoClient.from_uri("mongodb://hgt:hgt123@ds041178.mongolab.com:41178/hgtdb")
    db = mongo_client.db("hgtdb")
    coll = db["flow-shop-test-cases"]

    require 'open-uri'
    file = open(@url)
    @contents = file.read

    doc = { "name" => @name, "contents" => @contents }
    id = coll.insert(doc)

    #require 'uri'
    #require 'net/http'
    #@contents = Net::HTTP.get_response(URI.parse(@url).host, URI.parse(@url).path).body
  end
end

