require_relative 'objects'

# ----------------------------------------------------------------------------------------------------
# Generic:
# ----------------------------------------------------------------------------------------------------

module OneApi

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

    class GenericObject < OneApiModel

        # FIXME: WIthout this it is not a valid model
        oneapi_attr_accessor :ignore, FieldConversionRule.new(:ignore)

    end

    # ----------------------------------------------------------------------------------------------------
    # Messaging:
    # ----------------------------------------------------------------------------------------------------

    class Language < OneApiModel

      oneapi_attr_accessor :language_code, FieldConversionRule.new(:languageCode)
      oneapi_attr_accessor :use_single_shift, FieldConversionRule.new(:useSingleShift)
      oneapi_attr_accessor :use_locking_shift, FieldConversionRule.new(:useLockingShift)

    end

    class SMSRequest < OneApiModel

        oneapi_attr_accessor :sender_address, FieldConversionRule.new(:senderAddress)
        oneapi_attr_accessor :sender_name, FieldConversionRule.new(:senderName)
        oneapi_attr_accessor :message, FieldConversionRule.new()
        oneapi_attr_accessor :address, FieldConversionRule.new()
        oneapi_attr_accessor :client_correlator, FieldConversionRule.new(:clientCorrelator)
        oneapi_attr_accessor :notify_url, FieldConversionRule.new(:notifyUrl)
        oneapi_attr_accessor :callback_data, FieldConversionRule.new()
        oneapi_attr_accessor :language, ObjectFieldConverter.new(Language,'language')

    end

    class ResourceReference < OneApiModel

        oneapi_attr_accessor :client_correlator, PartOfUrlFieldConversionRule.new('resourceReference.resourceURL',-2)

    end

    class DeliveryInfo < OneApiModel

        oneapi_attr_accessor :address, FieldConversionRule.new(:address)
        oneapi_attr_accessor :delivery_status, FieldConversionRule.new(:deliveryStatus)

    end

    class DeliveryInfoList < OneApiModel

        oneapi_attr_accessor :delivery_info, ObjectArrayConversionRule.new(DeliveryInfo, json_field_name='deliveryInfoList.deliveryInfo')

    end

    class DeliveryInfoNotification < OneApiModel

        oneapi_attr_accessor :delivery_info, ObjectFieldConverter.new(DeliveryInfo, 'deliveryInfoNotification.deliveryInfo')
        oneapi_attr_accessor :callback_data, FieldConversionRule.new('deliveryInfoNotification.callbackData')

    end

    # ----------------------------------------------------------------------------------------------------
    # HLR:
    # ----------------------------------------------------------------------------------------------------

    class ServingMccMnc < OneApiModel

        oneapi_attr_accessor :mcc, FieldConversionRule.new(:mcc)
        oneapi_attr_accessor :mnc, FieldConversionRule.new(:mnc)

    end

    class TerminalRoamingExtendedData < OneApiModel

        oneapi_attr_accessor :destination_address, FieldConversionRule.new('destinationAddress')
        oneapi_attr_accessor :status_id, FieldConversionRule.new('statusId')
        oneapi_attr_accessor :done_time, FieldConversionRule.new('doneTime')
        oneapi_attr_accessor :price_per_message, FieldConversionRule.new('pricePerMessage')
        oneapi_attr_accessor :mcc_mnc, FieldConversionRule.new('mccMnc')
        oneapi_attr_accessor :serving_msc, FieldConversionRule.new('servingMsc')
        oneapi_attr_accessor :censored_serving_msc, FieldConversionRule.new('censoredServingMsc')
        oneapi_attr_accessor :gsm_error_code, FieldConversionRule.new('gsmErrorCode')
        oneapi_attr_accessor :original_network_name, FieldConversionRule.new('originalNetworkName')
        oneapi_attr_accessor :ported_network_name, FieldConversionRule.new('portedNetworkName')
        oneapi_attr_accessor :serving_hlr, FieldConversionRule.new('servingHlr')
        oneapi_attr_accessor :imsi, FieldConversionRule.new('imsi')
        oneapi_attr_accessor :original_network_prefix, FieldConversionRule.new('originalNetworkPrefix')
        oneapi_attr_accessor :original_country_prefix, FieldConversionRule.new('originalCountryPrefix')
        oneapi_attr_accessor :original_country_name, FieldConversionRule.new('originalCountryName')
        oneapi_attr_accessor :is_number_ported, FieldConversionRule.new('isNumberPorted')
        oneapi_attr_accessor :ported_network_prefix, FieldConversionRule.new('portedNetworkPrefix')
        oneapi_attr_accessor :ported_country_prefix, FieldConversionRule.new('portedCountryPrefix')
        oneapi_attr_accessor :ported_country_name, FieldConversionRule.new('portedCountryName')
        oneapi_attr_accessor :number_in_roaming, FieldConversionRule.new('numberInRoaming')

    end

    class TerminalRoamingStatus < OneApiModel

        oneapi_attr_accessor :servingMccMnc, ObjectFieldConverter.new(ServingMccMnc, 'servingMccMnc')
        oneapi_attr_accessor :address, FieldConversionRule.new()
        oneapi_attr_accessor :currentRoaming, FieldConversionRule.new('currentRoaming')
        oneapi_attr_accessor :resourceURL, FieldConversionRule.new('resourceURL')
        oneapi_attr_accessor :retrievalStatus, FieldConversionRule.new('retrievalStatus')
        oneapi_attr_accessor :callbackData, FieldConversionRule.new('callbackData')
        oneapi_attr_accessor :extendedData, ObjectFieldConverter.new(TerminalRoamingExtendedData, 'extendedData')

    end


    class TerminalRoamingStatusNotification < OneApiModel

        oneapi_attr_accessor :delivery_info, ObjectFieldConverter.new(TerminalRoamingStatus, 'terminalRoamingStatusList.roaming')
        oneapi_attr_accessor :callback_data, FieldConversionRule.new('terminalRoamingStatusList.roaming.callbackData')

    end

    # ----------------------------------------------------------------------------------------------------
    # Customer profile:
    # ----------------------------------------------------------------------------------------------------

    class CustomerProfile < OneApiModel

        oneapi_attr_accessor :id, FieldConversionRule.new()
        oneapi_attr_accessor :username, FieldConversionRule.new()
        oneapi_attr_accessor :forename, FieldConversionRule.new()
        oneapi_attr_accessor :surname, FieldConversionRule.new()
        oneapi_attr_accessor :street, FieldConversionRule.new()
        oneapi_attr_accessor :city, FieldConversionRule.new()
        oneapi_attr_accessor :zip_code, FieldConversionRule.new('zipCode')
        oneapi_attr_accessor :telephone, FieldConversionRule.new()
        oneapi_attr_accessor :gsm, FieldConversionRule.new()
        oneapi_attr_accessor :fax, FieldConversionRule.new()
        oneapi_attr_accessor :email, FieldConversionRule.new()
        oneapi_attr_accessor :msn, FieldConversionRule.new()
        oneapi_attr_accessor :skype, FieldConversionRule.new()
        oneapi_attr_accessor :country_id, FieldConversionRule.new('countryId')
        oneapi_attr_accessor :timezone_id, FieldConversionRule.new('timezoneId')
        oneapi_attr_accessor :primary_language_id, FieldConversionRule.new('primaryLanguageId')
        oneapi_attr_accessor :secondary_language_id, FieldConversionRule.new('secondaryLanguageId')

    end

    class Currency < OneApiModel

        oneapi_attr_accessor :id, FieldConversionRule.new()
        oneapi_attr_accessor :currency_name, FieldConversionRule.new('currencyName')
        oneapi_attr_accessor :symbol, FieldConversionRule.new()

    end

    class Currency < OneApiModel

        oneapi_attr_accessor :id, FieldConversionRule.new()
        oneapi_attr_accessor :currency_name, FieldConversionRule.new('currencyName')
        oneapi_attr_accessor :symbol, FieldConversionRule.new()

    end

    class AccountBalance < OneApiModel

        oneapi_attr_accessor :balance, FieldConversionRule.new()
        oneapi_attr_accessor :currency, ObjectFieldConverter.new(Currency)

    end

    # ----------------------------------------------------------------------------------------------------
    # Inbound:
    # ----------------------------------------------------------------------------------------------------

    class InboundSmsMessage < OneApiModel

        oneapi_attr_accessor :date_time, FieldConversionRule.new('dateTime')
        oneapi_attr_accessor :destination_address, FieldConversionRule.new('destinationAddress')
        oneapi_attr_accessor :message_id, FieldConversionRule.new('messageId')
        oneapi_attr_accessor :message, FieldConversionRule.new('message')
        oneapi_attr_accessor :resource_url, FieldConversionRule.new('resourceURL')
        oneapi_attr_accessor :sender_address, FieldConversionRule.new('senderAddress')

    end

    class InboundSmsMessages < OneApiModel

        oneapi_attr_accessor :inbound_sms_message, ObjectArrayConversionRule.new(InboundSmsMessage, 'inboundSMSMessageList.inboundSMSMessage')
        oneapi_attr_accessor :number_of_messages_in_this_batch, FieldConversionRule.new('inboundSMSMessageList.numberOfMessagesInThisBatch')
        oneapi_attr_accessor :total_number_of_pending_messages, FieldConversionRule.new('inboundSMSMessageList.totalNumberOfPendingMessages')
        oneapi_attr_accessor :callback_data, FieldConversionRule.new('inboundSMSMessageList.callbackData')

    end

end
