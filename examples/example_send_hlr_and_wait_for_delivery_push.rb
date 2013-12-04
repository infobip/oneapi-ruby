lib = File.expand_path('../../lib', __FILE__)
if File.exists?(lib)
  $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
end
require 'oneapi-ruby'

username = ARGV[0]
password = ARGV[1]
local_ip_address = ARGV[2]
destination_address = ARGV[3]

if OneApi::Utils.empty(username)
  print "Username: "
  username = gets.strip!
end

if OneApi::Utils.empty(password)
  print "Password: "
  password = gets.strip!
end

if OneApi::Utils.empty(local_ip_address)
  print "Local IP address: "
  local_ip_address = gets.strip!
end

if OneApi::Utils.empty(destination_address)
  print "Destination (MSISDN): "
  destination_address = gets.strip!
end

port = 9090

data_connection_client = OneApi::DataConnectionProfileClient.new(username, password)

notify_url = "http://#{local_ip_address}:#{port}"

# example:retrieve-roaming-status-with-notify-url
data_connection_client.retrieve_roaming_status(destination_address, notify_url)
# ----------------------------------------------------------------------------------------------------

dummy_web_server = OneApi::DummyWebServer.new(local_ip_address, port)
dummy_web_server.start 30

for method, url, headers, body in dummy_web_server.requests
    # example:on-roaming-status
    delivery_info = OneApi::DataConnectionProfileClient.unserialize_roaming_status(body)
    # ----------------------------------------------------------------------------------------------------
    puts delivery_info.inspect
end
