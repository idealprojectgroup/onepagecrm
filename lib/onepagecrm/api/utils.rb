module OnePageCRM
  module API
    module Utils

    private
      def objects_from_response(request_method, path, options={})
        response = send(request_method.to_sym, path, options)[:body]
      end
    end
  end
end