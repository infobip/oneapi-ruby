lib = File.expand_path('../../lib', __FILE__)
if File.exists?(lib)
  $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
end
require 'oneapi-ruby'

# In your script an HTTP POST request will be received, you should extract the body of this request...
http_body = '...'

#...and process it with:
# example:on-mo
inbound_messages = OneApi::SmsClient.unserialize_inbound_messages(http_body)
# ----------------------------------------------------------------------------------------------------
