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

    client = Savon.client do
      endpoint "http://scala-web-test.herokuapp.com/wstest" 
      #endpoint "http://0.0.0.0:8080/wstest"
      namespace "org.scalabound.test"
      strip_namespaces true
    end

    @soap_resps = [ 
      client.call(:test, message: { value: 888 }).body,
      client.call(:intArrayTest, message: { numbers: {item: [333,555] } }).body,
      client.call(:intMatrixTest, message: { matrix: {item: [{item: [1111,2222]}, {item: [3333,4444]}] } } ).body,
      client.call(:intMatrixToIntArray, message: { matrix: {item: [{item: [1111,2222]}, {item: [3333,4444]}] } } ).body,
    ]
  end

  def get_async
    respond_to do |format|
      format.js
    end
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

