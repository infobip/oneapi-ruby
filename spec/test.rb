require 'minitest/autorun'

require_relative 'oneapi/client'
 
class OneApiTest < MiniTest::Unit::TestCase

    def test_empty
        assert_equal OneApi::Utils.empty(0), true
        assert_equal OneApi::Utils.empty(1), false
        assert_equal OneApi::Utils.empty('aaa'), false
        assert_equal OneApi::Utils.empty(0.0), true
        assert_equal OneApi::Utils.empty([]), true
        assert_equal OneApi::Utils.empty([1]), false
        assert_equal OneApi::Utils.empty({}), true
        assert_equal OneApi::Utils.empty({'a' => 1}), false
        assert_equal OneApi::Utils.empty(''), true
    end

    def test_json_get
        json = '{"requestError":{"serviceException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":[""]},"policyException":null}}'
        request_error = OneApi::JSONUtils.get(json, 'requestError.serviceException.text')
        assert_equal('Request URI missing required component(s): ', request_error)
    end
 
    def test_json_get_hash_result
        json = '{"requestError":{"serviceException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":[""]},"policyException":null}}'
        value = OneApi::JSONUtils.get(json, 'requestError.serviceException')
        puts value.inspect
        assert_equal(value, {"messageId"=>"SVC0002", "variables"=>[""], "text"=>"Request URI missing required component(s): "})
    end

    def test_json_get_array_in_path
        json = '{"requestError":{"serviceException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":["abc", "cde"]},"policyException":null}}'
        value = OneApi::JSONUtils.get(json, 'requestError.serviceException.variables.1')
        assert_equal(value, "cde")
    end

    def test_json_get_with_or_paths
        json = '{"requestError":{"serviceException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":["abc", "cde"]},"policyException":null}}'
        value = OneApi::JSONUtils.get(json, 'requestError.serviceException.messageId | requestError.policyException.messageId')
        assert_equal(value, "SVC0002")

        json = '{"requestError":{"policyException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":["abc", "cde"]},"serviceException":null}}'
        value = OneApi::JSONUtils.get(json, 'requestError.serviceException.messageId | requestError.policyException.messageId')
        assert_equal(value, "SVC0002")
    end

    def test_exception_serialization
        json = '{"requestError":{"serviceException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":[""]},"policyException":null}}'

        sms_exception = OneApi::Conversions.from_json(OneApi::OneApiError, json, nil)

        assert(sms_exception)
        assert_equal(sms_exception.message_id, 'SVC0002')
        assert_equal(sms_exception.text, 'Request URI missing required component(s): ')
    end
 
    def test_exception_object_array
        json = '{"deliveryInfoList":{"deliveryInfo":[{"address":null,"deliveryStatus":"DeliveryUncertain1"},{"address":null,"deliveryStatus":"DeliveryUncertain2"}],"resourceURL":"http://api.parseco.com/1/smsmessaging/outbound/TODO/requests/28drx7ypaqr/deliveryInfos"}}'

        object = OneApi::Conversions.from_json(OneApi::DeliveryInfoList, json, nil)

        assert(object)
        assert(object.delivery_info)
        assert_equal(2, object.delivery_info.length)
        assert_equal("DeliveryUncertain1", object.delivery_info[0].delivery_status)
        assert_equal("DeliveryUncertain2", object.delivery_info[1].delivery_status)
    end

end
