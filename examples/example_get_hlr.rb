lib = File.expand_path('../../lib', __FILE__)
if File.exists?(lib)
  $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
end
require 'oneapi-ruby'

username = ARGV[0]
password = ARGV[1]
destination_address = ARGV[2]

if OneApi::Utils.empty(username)
  print "Username: "
  username = gets.strip!
end

if OneApi::Utils.empty(password)
  print "Password: "
  password = gets.strip!
end

if OneApi::Utils.empty(destination_address)
  print "Destination (MSISDN): "
  destination_address = gets.strip!
end

# example:data-connection-client
data_connection_client = OneApi::DataConnectionProfileClient.new(username, password)
# ----------------------------------------------------------------------------------------------------

# example:retrieve-roaming-status
result = data_connection_client.retrieve_roaming_status(destination_address)
# ----------------------------------------------------------------------------------------------------

puts result.inspect
