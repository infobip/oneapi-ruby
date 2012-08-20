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

sms_client = OneApi::SmsClient.new(username, password)
sms_client.login

# example:retrieve-inbound-messages
result = sms_client.retrieve_inbound_messages()
# ----------------------------------------------------------------------------------------------------

puts result.inspect
