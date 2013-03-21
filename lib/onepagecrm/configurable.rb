# Copied from https://github.com/sferik/twitter/blob/v4.6.2/lib/twitter/configurable.rb
# Modified with keys related to OnePageCRM.

require 'forwardable'

module OnePageCRM
  module Configurable

    extend Forwardable

    attr_writer :login, :password, :uid, :api_key
    attr_accessor :url, :connection_options, :middleware
    def_delegator :options, :hash

    class << self
      def keys
        @keys ||= [
          :login,
          :password,
          :uid,
          :api_key,
          :url,
          :connection_options,
          :middleware
        ]
      end
    end

    def configure
      yield self
      self
    end

    def reset!
      OnePageCRM::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", OnePageCRM::Default.options[key])
      end
      self
    end

  private

    def options
      Hash[OnePageCRM::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

  end
end