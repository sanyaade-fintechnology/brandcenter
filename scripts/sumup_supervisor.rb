# encoding: UTF-8
require "json"
require "net/https"

# CONFIG = {
#   :host => "triangle.sumup.com",
#   :port => "443",
#   :scheme => "https"
# }

CONFIG = {:host => "127.0.0.1", :port => "9292", :scheme => "http", :version => "0.1"}

status_file_path = "#{File.dirname(__FILE__)}/../status.json"

#
# JSON RPC Helper to make the calls
#
class JsonRpc
  attr_accessor :host, :port, :scheme, :body

  # Initialize
  def initialize host, port, scheme
    @host = host
    @port = port
    @scheme = scheme
  end

  #
  # Do the JSON RPC request
  #
  def post endpoint, method, params, headers = {}
    http = Net::HTTP.new(host, port)

    if scheme == "https"
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    json_params = {:jsonrpc => "2.0"}
    json_params[:params] = params
    json_params[:method] = method
    json_params[:id] = method.upcase+"_#{Time.now.to_f}"

    req = Net::HTTP::Post.new(endpoint)
    req.body = JSON(json_params).to_str
    @body = req.body
    req["Content-Type"] = "application/json"
    headers.each{|header, value| req.add_field header, value }

    begin
      response = http.request(req)
      return JSON(response.body)
    rescue Exception => e
      puts "ERROR #{e.message}"
    end
  end
end

@json_rpc = JsonRpc.new CONFIG[:host], CONFIG[:port], CONFIG[:scheme]

# Check Services
# login - AuthServer/login
# signup - CommonServer/getCountries
# transactions - PaymentServer/getPaymentTypes
def check_service(name, old_status)
  common_params = {
    :location => {
      :lat => 53.3426,
      :lon => -6.2488,
      :horizontal_accuracy => 0
    },
    :language => "en",
    :app => {
      :name => "MWI"
    }
  }
  services = {
    "login" => ->(){
      login_params = {
        :username => "andrei.balcanasu+status@sumup.com",
        :password => "1234567890"
      }
      @json_rpc.post "/api/0.1/auth", "login", login_params.merge(common_params)
    },
    "transactions" => ->(){
      login_response = services["login"].call
      if login_response["params"]
        params = {
          accesstoken: login_response["params"]["accesstoken"],
          transaction_value: "123.45"
        }
        @json_rpc.post "/api/0.1/payment", "getPaymentTypes", params.merge(common_params)
      else
        login_response
      end
    },
    "signups" => ->(){
      @json_rpc.post("/api/0.1/common", "getCountries", {}.merge(common_params))
    }
  }
  response = services[name].call
  require 'debugger'; debugger
  if response["error"] && response["error"]["code"] == 9
    return {
      status: "offline",
      details: response["error"]["message"]
    }
  else
    old_status
  end
end

def get_overall_status(status)
  overall_statuses = {
    "online" => {
      "status" => "online",
      "details" => "All systems are up and running."
      },
    "problems" => {
      "status" => "problems",
      "details" => "We're currently experiencing a few glitches."
      },
    "offline" => {
      "status" => "offline",
      "details" => "Systems offline. Our engineers are on it. Please hang on."
    }
  }
  overall_statuses[status]
end

# Read current JSON
# Check only the services marked as online

sumup_status = JSON.parse(IO.read(status_file_path))

p sumup_status

# overall_statuses = []

# sumup_status["services"].each do |service_name, status|
#   status_name = status["status"]
#   if status["status"] == "online"
#     new_status = check_service(service_name, status)
#     sumup_status["services"][service_name] = new_status
#     status_name = new_status["status"]
#   end
#   overall_statuses << status_name
# end

# # compile the overall status
# sumup_status["overall"] = case overall_statuses.length
# when overall_statuses.count("online")
#   get_overall_status("online")
# when overall_statuses.count("offline")
#   get_overall_status("offline")
# else
#   get_overall_status("problems")
# end

sumup_status["updated_at"] = Time.now.to_i * 1000

p sumup_status

File.open(status_file_path, 'w') {
  |file| file.write(JSON.pretty_generate(sumup_status))
}
