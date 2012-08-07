=begin
require 'rubygems'
require 'ruby-debug'
=end

require 'oneapi/objects'

# ----------------------------------------------------------------------------------------------------
# Generic:
# ----------------------------------------------------------------------------------------------------

class OneApiAuthentication < OneApiModel

    oneapi_attr_accessor :username, FieldConversionRule.new()
    oneapi_attr_accessor :password, FieldConversionRule.new()
    oneapi_attr_accessor :ibsso_token, FieldConversionRule.new('login.ibAuthCookie | TODO')
    oneapi_attr_accessor :authenticated, FieldConversionRule.new()
    oneapi_attr_accessor :verified, FieldConversionRule.new('login.verified | TODO')

end

class OneApiError < OneApiModel

    oneapi_attr_accessor :message_id, FieldConversionRule.new('requestError.serviceException.messageId | requestError.policyException.messageId')
    oneapi_attr_accessor :text, FieldConversionRule.new('requestError.serviceException.text | requestError.policyException.text')
    oneapi_attr_accessor :variables, FieldConversionRule.new('requestError.serviceException.variables | requestError.policyException.variables')

end

# ----------------------------------------------------------------------------------------------------
# Messaging:
# ----------------------------------------------------------------------------------------------------

class SMSRequest < OneApiModel

    oneapi_attr_accessor :sender_address, FieldConversionRule.new(:senderAddress)
    oneapi_attr_accessor :sender_name, FieldConversionRule.new(:senderName)
    oneapi_attr_accessor :message, FieldConversionRule.new()
    oneapi_attr_accessor :address, FieldConversionRule.new()
    oneapi_attr_accessor :client_correlator, FieldConversionRule.new(:clientCorrelator)
    oneapi_attr_accessor :notify_url, FieldConversionRule.new(:notifyUrl)
    oneapi_attr_accessor :callback_data, FieldConversionRule.new()

end

class ResourceReference < OneApiModel

    oneapi_attr_accessor :client_correlator, LastPartOfUrlFieldConversionRule.new('resourceReference.resourceURL')

end

class DeliveryInfo < OneApiModel

    oneapi_attr_accessor :delivery_status, FieldConversionRule.new('deliveryStatus')

    def initialize
    end

end
