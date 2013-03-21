# Copied from https://github.com/sferik/twitter/blob/v4.6.2/lib/twitter/client.rb
# Modified to use the OnePageCRM signature for authorization.

require 'faraday'
require 'multi_json'
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

    def request(method, path, params={}, signature_params=params)
      connection.send(method.to_sym, path, params) do |request|

      end.env
    rescue Faraday::Error::ClientError
      raise OnePageCRM::Error
    rescue MultiJson::DecodeError
      raise OnePageCRM::Error
    end

    def connection
      @connection ||= Faraday.new(@url, @connection_options.merge(:builder => @middleware))
    end

  end
end