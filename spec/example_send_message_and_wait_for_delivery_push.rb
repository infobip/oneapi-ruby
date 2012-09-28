require_relative 'oneapi/client'

username = ARGV[0]
password = ARGV[1]
local_ip_address = ARGV[2]

if username == nil or username.empty?
    puts 'No username given'
    exit
end
if password == nil or password.empty?
    puts 'No password given'
    exit
end
if local_ip_address == nil or local_ip_address.empty?
    puts 'No local ip address given'
    exit
end

port = 9090

sms_client = OneApi::SmsClient.new(username, password)

# example:prepare-message-with-notify-url
sms = OneApi::SMSRequest.new
sms.sender_address = '38598123456'
sms.address = '38598123456'
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
