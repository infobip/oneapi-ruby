require_relative 'oneapi/client'

# In your script an HTTP POST request will be received, you should extract the body of this request...
http_body = '...'

#...and process it with:
# example:on-mo
inbound_messages = OneApi::SmsClient.unserialize_inbound_messages(http_body)
# ----------------------------------------------------------------------------------------------------
