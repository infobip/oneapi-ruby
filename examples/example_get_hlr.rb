lib = File.expand_path('../../lib', __FILE__)
if File.exists?(lib)
  $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
end
require 'oneapi-ruby'

username = ARGV[0]
password = ARGV[1]
destination_address = ARGV[2]

if OneApi::Utils.empty(username)
    puts "No username given"
    exit
end
if OneApi::Utils.empty(password)
    puts "No password given"
    exit
end
if OneApi::Utils.empty(destination_address)
    puts "No destination_address given"
    exit
end

# example:data-connection-client
data_connection_client = OneApi::DataConnectionProfileClient.new(username, password)
# ----------------------------------------------------------------------------------------------------

# example:retrieve-roaming-status
result = data_connection_client.retrieve_roaming_status(destination_address)
# ----------------------------------------------------------------------------------------------------

puts result.inspect
