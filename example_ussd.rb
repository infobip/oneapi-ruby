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

# example:ussd-client
ussd_client = OneApi::UssdClient.new(username, password)
# ----------------------------------------------------------------------------------------------------

# example:ussd
message = nil
while message != '1'
    result = ussd_client.send_message(destination_address, 'Your favourite language is\n1. Ruby\n2. Other')
    message = result.message
end

ussd_client.close_session('Cool')
# ----------------------------------------------------------------------------------------------------
