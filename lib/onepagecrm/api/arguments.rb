# Copied from https://github.com/sferik/twitter/blob/v4.6.2/lib/twitter/api/arguments.rb

module OnePageCRM
  module API
    class Arguments < Array
      attr_reader :options

      def initialize(args)
        @options = args.last.is_a?(::Hash) ? args.pop : {}
        super(args)
      end

    end
  end
end