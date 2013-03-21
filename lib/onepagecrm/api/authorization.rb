require 'onepagecrm/api/arguments'
require 'onepagecrm/api/utils'

module OnePageCRM
  module API
    module Authorization
      include OnePageCRM::API::Utils
      
      def login
        arguments = OnePageCRM::API::Arguments.new([{:login => @login, :password => @password}])
        objects_from_response(:post, "/api/auth/login.json", arguments.options)
      end

      def logout
        objects_from_response(:get, "/api/auth/logout.json")
      end

    end
  end
end