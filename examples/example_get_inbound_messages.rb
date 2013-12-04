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

sms_client = OneApi::SmsClient.new(username, password)

# example:retrieve-inbound-messages
result = sms_client.retrieve_inbound_messages()
# ----------------------------------------------------------------------------------------------------

puts result.inspect
