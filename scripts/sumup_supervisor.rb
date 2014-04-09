# encoding: UTF-8
require "json"


status_file_path = "#{File.dirname(__FILE__)}/../status.json"

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
