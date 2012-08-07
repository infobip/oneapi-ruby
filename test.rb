require 'test/unit'

require 'oneapi/utils'
require 'oneapi/objects'
require 'oneapi/models'
 
class OneApiTest < Test::Unit::TestCase

    def test_json_get
        json = '{"requestError":{"serviceException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":[""]},"policyException":null}}'
        request_error = JSONUtils.get(json, 'requestError.serviceException.text')
        assert_equal('Request URI missing required component(s): ', request_error)
    end
 
    def test_json_get_hash_result
        json = '{"requestError":{"serviceException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":[""]},"policyException":null}}'
        value = JSONUtils.get(json, 'requestError.serviceException')
        puts value.inspect
        assert_equal(value, {"messageId"=>"SVC0002", "variables"=>[""], "text"=>"Request URI missing required component(s): "})
    end

    def test_json_get_array_in_path
        json = '{"requestError":{"serviceException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":["abc", "cde"]},"policyException":null}}'
        value = JSONUtils.get(json, 'requestError.serviceException.variables.1')
        assert_equal(value, "cde")
    end

    def test_json_get_with_or_paths
        json = '{"requestError":{"serviceException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":["abc", "cde"]},"policyException":null}}'
        value = JSONUtils.get(json, 'requestError.serviceException.messageId | requestError.policyException.messageId')
        assert_equal(value, "SVC0002")

        json = '{"requestError":{"policyException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":["abc", "cde"]},"serviceException":null}}'
        value = JSONUtils.get(json, 'requestError.serviceException.messageId | requestError.policyException.messageId')
        assert_equal(value, "SVC0002")
    end

    def test_exception_serialization
        json = '{"requestError":{"serviceException":{"text":"Request URI missing required component(s): ","messageId":"SVC0002","variables":[""]},"policyException":null}}'

        sms_exception = Conversions.from_json(OneApiError, json, nil)

        assert(sms_exception)
        assert_equal(sms_exception.message_id, 'SVC0002')
        assert_equal(sms_exception.text, 'Request URI missing required component(s): ')
    end
 
end
