include Mongo

class MainController < ApplicationController

  def index

    @solve_result = execute_soap_request(:solve, { 
      task: { 
        jobCount: 2, 
        machineCount: 3,
        opDurationsForJobs: {
          item: [
            { item: [1, 2, 3] }, 
            { item: [4, 5, 6] }
          ]
        }
      }
    }, :solve_response)

  end

  def do_sleep
    sleep 10
  end

  def ajax_init_task
    #@task_id = execute_soap_request(:initTask, {}, :init_task_response)
    
    @task_id = execute_soap_request(:postTask, {
      task: { 
        jobCount: 2, 
        machineCount: 3,
        opDurationsForJobs: {
          item: [
            { item: [1, 2, 3] }, 
            { item: [4, 5, 6] }
          ]
        }
      }
    }, :post_task_response)
  end

  def ajax_get_all_progresses
    @all_progresses = execute_soap_request(:getAllProgresses, { 
      taskIds: { item: params[:taskIds] } 
    }, :get_all_progresses_response)
  end

  def ajax_get_result
    @result = execute_soap_request(:getResult, { 
      taskId: params[:taskId] 
    }, :get_result_response)
  end

  def ajax_load_animation
    @full_result = execute_soap_request(:getFullResult, { 
      taskId: params[:taskId] 
    }, :get_full_result_response)
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

  private

    def execute_soap_request(method, args, retval)
      respond_to do |format|
        format.js do 
          client = Savon.client do
            endpoint "http://posh-wolf-ws.herokuapp.com" 
            #endpoint "http://0.0.0.0:8080"
            namespace "com.poshwolf.ws"
            strip_namespaces true
          end
          puts args
          client.call(method, message: args).body[retval][:return]
        end
        format.html do 
          client = Savon.client do
            endpoint "http://posh-wolf-ws.herokuapp.com" 
            #endpoint "http://0.0.0.0:8080"
            namespace "com.poshwolf.ws"
            strip_namespaces true
          end
          puts args
          client.call(method, message: args).body[retval][:return]
        end
      end
    end
end

