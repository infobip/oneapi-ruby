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

# example:prepare-message-without-notify-url-with-nli-support
language = OneApi::Language.new
language.language_code = 'TR'
language.use_single_shift = true
language.use_locking_shift = false

sms = OneApi::SMSRequest.new
sms.sender_address = '38598123456'
sms.address = destination_address
sms.message = 'Türkçesi bu yönünden dolayı diğer Türk dil42leriyle ortak ya da ayrık bulunan onlarca eke sahiptir.'
sms.callback_data = 'Any string'
sms.language = language

# ----------------------------------------------------------------------------------------------------

# example:send-message
result = sms_client.send_sms(sms)
