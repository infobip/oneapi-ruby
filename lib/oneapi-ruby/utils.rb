#require 'pry'
require 'json'
require 'socket'

module OneApi

    class JSONUtils

        def self.get_json(json)
            if json.instance_of? String
                return JSON.parse(json)
            end

            return json
        end

        def self.get(json, field)
            json = JSONUtils.get_json(json)

            if not field
                return nil
            end

            if field.instance_of? Symbol
                field = field.to_s
            end

            if field.include?('|') then
                field_parts = field.split('|')
                for field_part in field_parts
                    value = JSONUtils.get(json, field_part.strip)
                    if value
                        return value
                    end
                end
                return nil
            end

            result = nil
            parts = field.split('.')
            result = json
            for part in parts
                if result == nil
                    return nil
                end

                if part.to_i.to_s == part
                    # Int index => array:
                    result = result[part.to_i]
                else
                    # Hash:
                    result = result[part]
                end
            end

            result
        end

    end

    class Utils

        def self.empty(obj)
            if obj == nil
                return true
            end

            if obj.instance_of? Hash or obj.instance_of? Array or obj.instance_of? String
                return obj.size == 0
            end

            return obj == 0
        end

        def self.get_random_string(length, chars)
            if not length
                raise "Invalid random string length: #{length}"
            end
            if not chars
                raise "Invalid random chars: #{chars}"
            end

            result = ''

            for i in 0..length
                result += chars[rand(chars.length - 1), 1]
            end

            result
        end

        def self.get_random_alphanumeric_string(length=10)
            get_random_string(length, 'qwertzuiopasdfghjklyxcvbnm123456789')
        end

    end

    # Web server, to be used only in examples
    class DummyWebServer

        attr_accessor :requests

        def initialize(ip_address, port)
            @webserver = TCPServer.new(ip_address, port)
            @session = nil
            @requests = []
        end

        def start(seconds)
            Thread.new {
                while (@session = @webserver.accept)
                    request_string = @session.sysread 10000
                    @session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
                    @session.print("OK")
                    @session.close
                    @requests.push(parse_request_string request_string)
                end
            }

            sleep(seconds)

            @webserver.close
            if @session != nil
                begin
                    @session.close
                rescue
                end
            end
        end

        def parse_request_string request_string
            lines = request_string.split(/\n/)
            method, url, http_version = lines[0].split(' ')
            headers = {}
            body = nil
            for line in lines[1,lines.length]
                if body == nil
                    if line.strip == ''
                        body = ''
                    else
                        index = line.index ':'
                        key = line[0,index].strip
                        value = line[index + 1, line.length].strip
                        headers[key] = value
                    end
                end

                if body != nil
                    body += line + "\n"
                end
            end
            return method, url, headers, body.strip
        end

    end

=begin
dummy_web_server = DummyWebServer.new('localhost', 2000)
dummy_web_server.start 10
puts dummy_web_server.requests
=end


end
