#!/bin/env ruby
# encoding: utf-8
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

# example:prepare-message
sms = OneApi::SMSRequest.new
sms.sender_address = 'SENDER_NAME'
sms.address = destination_address
sms.message = 'Simple SMS example'
# ----------------------------------------------------------------------------------------------------

# example:send-message
result = sms_client.send_sms(sms)
