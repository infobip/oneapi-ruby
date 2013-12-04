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

sms_client = OneApi::SmsClient.new(username, password)

# example:prepare-message-with-notify-url
sms = OneApi::SMSRequest.new
sms.sender_address = 'INFOSMS'
sms.address = destination_address
sms.message = 'Test message'
sms.callback_data = 'Any string'
sms.notify_url = "http://#{local_ip_address}:#{port}"
# ----------------------------------------------------------------------------------------------------

puts sms.inspect

result = sms_client.send_sms(sms)

dummy_web_server = OneApi::DummyWebServer.new(local_ip_address, port)
dummy_web_server.start 30

for method, url, headers, body in dummy_web_server.requests
    # example:on-delivery-notification
    delivery_info = OneApi::SmsClient.unserialize_delivery_status(body)
    # ----------------------------------------------------------------------------------------------------
end
