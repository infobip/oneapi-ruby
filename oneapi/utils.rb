=begin
require_relative 'rubygems'
require_relative 'ruby-debug'
=end

require 'rubygems'
require 'json'

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

end
