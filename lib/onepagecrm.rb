require 'onepagecrm/configurable'
require 'onepagecrm/client'
require 'onepagecrm/default'

module OnePageCRM
  class << self
    include OnePageCRM::Configurable

    def client
      @client ||= OnePageCRM::Client.new(options) unless defined?(@client) && @client.hash == options.hash
      @client
    end

  private

  end
end

OnePageCRM.reset!