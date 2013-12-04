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

# example:initialize-sms-client
sms_client = OneApi::SmsClient.new(username, password)
# ----------------------------------------------------------------------------------------------------

# example:prepare-message-without-notify-url
sms = OneApi::SMSRequest.new
sms.sender_address = '38598123456'
sms.address = destination_address
sms.message = 'Test message'
sms.callback_data = 'Any string'
# ----------------------------------------------------------------------------------------------------

# example:send-message
result = sms_client.send_sms(sms)

# Store the client correlator to be able to query for the delivery status later:
client_correlator = result.client_correlator
# ----------------------------------------------------------------------------------------------------

# example:query-for-delivery-status
delivery_status = sms_client.query_delivery_status(client_correlator)
# ----------------------------------------------------------------------------------------------------

sleep(10)

for delivery_info in delivery_status.delivery_info
    puts "Delivery status id #{delivery_info.delivery_status}"
end
