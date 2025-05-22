## ⚠️ Deprecated

**This repository is deprecated and no longer actively maintained, it will be archived in the near future.**

You’re still welcome to browse or fork the code, but issues and pull requests will not be monitored.

There is currently **no active Ruby-based alternative** available. However, similar functionality is available in other languages:
* Java: [infobip-api-java-client](https://github.com/infobip/infobip-api-java-client)
* C#: [infobip-api-csharp-client](https://github.com/infobip/infobip-api-csharp-client)
* Python: [infobip-api-python-client](https://github.com/infobip/infobip-api-python-client)
* PHP: [infobip-api-php-client](https://github.com/infobip/infobip-api-php-client)
* Go: [infobip-api-go-client](https://github.com/infobip/infobip-api-go-client)

OneApi ruby client
============================

Basic messaging example
-----------------------

First initialize the messaging client using your username and password:

    sms_client = OneApi::SmsClient.new(username, password)


An exception will be thrown if your username and/or password are incorrect.

Prepare the message:

    sms = OneApi::SMSRequest.new
    sms.sender_address = '38598123456'
    sms.address = destination_address
    sms.message = 'Test message'
    sms.callback_data = 'Any string'


Send the message:

    result = sms_client.send_sms(sms)
    
    # Store the client correlator to be able to query for the delivery status later:
    client_correlator = result.client_correlator


Later you can query for the delivery status of the message:

    delivery_status = sms_client.query_delivery_status(client_correlator)


Possible statuses are: **DeliveredToTerminal**, **DeliveryUncertain**, **DeliveryImpossible**, **MessageWaiting** and **DeliveredToNetwork**.

Messaging with notification push example
-----------------------

Same as with the standard messaging example, but when preparing your message:

    sms = OneApi::SMSRequest.new
    sms.sender_address = '38598123456'
    sms.address = '38598123456'
    sms.message = 'Test message'
    sms.callback_data = 'Any string'
    sms.notify_url = "http://#{local_ip_address}:#{port}"


When the delivery notification is pushed to your server as a HTTP POST request, you must process the body of the message with the following code:

    delivery_info = OneApi::SmsClient.unserialize_delivery_status(body)


Sending message with special characters example
-----------------------

If you want to send message with special characters, this is how you prepare your message:

	#Create Language object
	language = OneApi::Language.new

	#set specific language code
	language.language_code = 'TR'

	#use single shift table for specific language ('false' or 'true')
	language.use_single_shift = true

	#use locking shift table for specific language ('false' or 'true')
	language.use_locking_shift = false

	sms = OneApi::SMSRequest.new
	sms.sender_address = '38598123456'
	sms.address = destination_address
	sms.message = 'Some text in Turkish'
	sms.callback_data = 'Any string'
	sms.language = language

Currently supported languages (with their language codes) are: `Spanish - "SP"`, `Portuguese - "PT"`, `Turkish - "TR"`.

HLR example
-----------------------

Initialize and login the data connection client:

    data_connection_client = OneApi::DataConnectionProfileClient.new(username, password)


Retrieve the roaming status (HLR):

    result = data_connection_client.retrieve_roaming_status(destination_address)


HLR with notification push example
-----------------------

Similar to the previous example, but this time you must set the notification url where the result will be pushed:

    data_connection_client.retrieve_roaming_status(destination_address, notify_url)


When the roaming status notification is pushed to your server as a HTTP POST request, you must process the body of the message with the following code:

    delivery_info = OneApi::DataConnectionProfileClient.unserialize_roaming_status(body)


Retrieve inbound messages example
-----------------------

With the existing sms client (see the basic messaging example to see how to start it):

    result = sms_client.retrieve_inbound_messages()


Inbound message push example
-----------------------

The subscription to recive inbound messages can be set up on our site.
When the inbound message notification is pushed to your server as a HTTP POST request, you must process the body of the message with the following code:

    inbound_messages = OneApi::SmsClient.unserialize_inbound_messages(http_body)


License
-------

This library is licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
