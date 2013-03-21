# Copied from https://github.com/sferik/twitter/blob/v4.6.2/lib/twitter/default.rb
# Modified to use OnePageCRM keys.

require 'faraday'
require 'onepagecrm/configurable'
require 'onepagecrm/response/parse_json'
require 'onepagecrm/version'

module OnePageCRM
  module Default
    URL = "https://www.onepagecrm.com" unless defined? OnePageCRM::Default::URL
    CONNECTION_OPTIONS = {
      :headers => {
        :accept       => 'application/json',
        :user_agent   => "OnePageCRM Ruby Gem #{OnePageCRM::Version}"
      }
    } unless defined? OnePageCRM::Default::CONNECTION_OPTIONS
    MIDDLEWARE = Faraday::Builder.new do |builder|
      # Convert request params to "www-form-urlencoded"
      builder.use Faraday::Request::UrlEncoded
      # Parse JSON response bodies using MultiJson
      builder.use OnePageCRM::Response::ParseJson
      # Set Faraday's HTTP adapter
      builder.adapter Faraday.default_adapter
    end unless defined? OnePageCRM::Default::MIDDLEWARE

    class << self
      def options
        Hash[OnePageCRM::Configurable.keys.map{|key| [key, send(key)]}]
      end

      def login
        ENV['ONEPAGECRM_LOGIN']
      end

      def password
        ENV['ONEPAGECRM_PASSWORD']
      end

      def uid
        ENV['ONEPAGECRM_UID']
      end

      def api_key
        ENV['ONEPAGECRM_API_KEY']
      end

      def url
        URL
      end

      def connection_options
        CONNECTION_OPTIONS
      end

      def middleware
        MIDDLEWARE
      end
    end
  end
end