require 'net/http'

require 'oneapi/objects'
require 'oneapi/models'

class OneApiClient

    def initialize(username, password, base_url=nil)
        @username = username
        @password = password
        if base_url:
            @base_url = base_url
        else
            # TODO: https
            @base_url = 'http://api.parseco.com'
            #@base_url = 'http://p1-fr-1:9151'
        end

        if @base_url[-1, 1] != '/'
            @base_url += '/'
        end

        @oneapi_authentication = nil
    end


    def login()

        params = {
                'username' => @username,
                'password' => @password,
        }

        is_success, result = self.execute_POST('/1/customerProfile/login', params)

        return self.fill_oneapi_authentication(result, is_success)
    end

    def execute_POST(url, params)
        uri = URI(get_rest_url(url))

        http = Net::HTTP.new(uri.host, uri.port)

        request = Net::HTTP::Post.new(uri.request_uri)

        request["User-Agent"] = "OneApi Ruby client" # TODO: Add version!
        if @oneapi_authentication and @oneapi_authentication.ibsso_token
            request['Authorization'] = "IBSSO #{@oneapi_authentication.ibsso_token}"
        end

        request.set_form_data(params)

        response = http.request(request)

        http_code = response.code.to_i
        is_success = 200 <= http_code && http_code < 300

        return is_success, response.body
    end

    def get_rest_url(rest_path)
        if not rest_path
            return @base_url
        end

        if rest_path[0, 1] == '/'
            return @base_url + rest_path[1, rest_path.length]
        end

        @base_url + rest_path
    end

    def fill_oneapi_authentication(json, is_success)
        @oneapi_authentication = Conversions.from_json(OneApiAuthentication, json, !is_success)
        @oneapi_authentication.username = @username
        @oneapi_authentication.password = @password

        @oneapi_authentication.authenticated = @oneapi_authentication.ibsso_token ? @oneapi_authentication.ibsso_token.length > 0 : false

        @oneapi_authentication
    end

end

class SmsClient < OneApiClient

    def initialize(username, password, base_url=nil)
        super(username, password, base_url)
    end

    def send_sms(sms)
        client_correlator = sms.client_correlator
        if not client_correlator
            client_correlator = Utils.get_random_alphanumeric_string()
        end

        params = {
            'senderAddress' => sms.sender_address,
            'address' => sms.address,
            'message' => sms.message,
            'clientCorrelator' => client_correlator,
            'senderName' => "tel:#{sms.sender_address}"
        }

        if sms.notify_url
            params['notifyURL'] = sms.notify_url
        end
        if sms.callback_data
            params['callbackData'] = sms.callback_data
        end

        is_success, result = self.execute_POST(
                "/1/smsmessaging/outbound/#{sms.sender_address}/requests",
                params
        )

        return Conversions.from_json(ResourceReference, result, !is_success)
    end

end
