# Copied from https://github.com/sferik/twitter/blob/v4.6.2/lib/twitter/client.rb
# Modified to use the OnePageCRM signature for authorization.

require 'faraday'
require 'multi_json'
require 'digest/sha1'
require 'openssl'
require 'onepagecrm/api/authorization'
require 'onepagecrm/api/contacts'
require 'onepagecrm/configurable'

module OnePageCRM

  class Client
    include OnePageCRM::API::Authorization
    include OnePageCRM::API::Contacts
    include OnePageCRM::Configurable

    def initialize(options={})
      OnePageCRM::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || OnePageCRM.instance_variable_get(:"@#{key}"))
      end
    end

    def get(path, params={})
      request(:get, path, params)
    end

    def post(path, params={})
      request(:post, path, params)
    end

    def put(path, params={})
      request(:put, path, params)
    end

    def delete(path, params={})
      request(:delete, path, params)
    end

  private

    def request(method, path, params={})
      connection.send(method.to_sym, path, params) do |request|
        request.body = MultiJson.dump(request.body)
        request.headers[:"x-onepagecrm-uid"]  = uid_header
        request.headers[:"x-onepagecrm-ts"]   = ts_header
        request.headers[:"x-onepagecrm-auth"] = auth_header(method, path, request.body)
      end.env
    rescue Faraday::Error::ClientError
      raise OnePageCRM::Error
    rescue MultiJson::DecodeError
      raise OnePageCRM::Error
    end

    def connection
      @connection ||= Faraday.new(@url, @connection_options.merge(:builder => @middleware))
    end

    def uid_header
      @uid
    end

    def ts_header
      utc_timestamp.to_s
    end

    # See: http://www.onepagecrm.com/api/api-doc-for-dev-signature-value.html
    def auth_header method, path, body 
      hmac_sha256(auth_params(method, path, body).join('.'), @api_key)
    end

    def auth_params method, path, body
      params = [@uid, utc_timestamp, method.to_s.upcase, sha1(path)]
      if [:put, :post].include?(method)
        params << sha1(body)
      else
        params
      end
    end

    def utc_timestamp
      Time.now.utc.to_i
    end

    def sha1 string
      Digest::SHA1.hexdigest(string)
    end

    def hmac_sha256 string, key
      OpenSSL::HMAC.hexdigest("sha256", key, string)
    end
  end
end