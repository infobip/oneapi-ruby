require_relative 'oneapi/client'

username = ARGV[0]
password = ARGV[1]
local_ip_address = ARGV[2]
destination_address = ARGV[3]

if OneApi::Utils.empty(username)
    puts "No username given"
    exit
end
if OneApi::Utils.empty(password)
    puts "No password given"
    exit
end
if local_ip_address == nil or local_ip_address.empty?
    puts 'No local ip address given'
    exit
end
if OneApi::Utils.empty(destination_address)
    puts "No destination_address given"
    exit
end

port = 9090

data_connection_client = OneApi::DataConnectionProfileClient.new(username, password)
data_connection_client.login

notify_url = "http://#{local_ip_address}:#{port}"

data_connection_client.retrieve_roaming_status(destination_address, notify_url)

dummy_web_server = OneApi::DummyWebServer.new(local_ip_address, port)
dummy_web_server.start 30

for method, url, headers, body in dummy_web_server.requests
    # example:on-roaming-status
    delivery_info = OneApi::DataConnectionProfileClient.convert_roaming_status_notification(body)
    # ----------------------------------------------------------------------------------------------------
    puts delivery_info.inspect
end
