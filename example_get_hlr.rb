require_relative 'oneapi/client'

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
data_connection_client.login
# ----------------------------------------------------------------------------------------------------

# example:retrieve-roaming-status
result = data_connection_client.retrieve_roaming_status(destination_address)
# ----------------------------------------------------------------------------------------------------

puts result.inspect
