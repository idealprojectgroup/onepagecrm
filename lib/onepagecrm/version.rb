module OnePageCRM
  class Version
    MAJOR = 0 unless defined? OnePageCRM::Version::MAJOR
    MINOR = 0 unless defined? OnePageCRM::Version::MINOR
    PATCH = 1 unless defined? OnePageCRM::Version::PATCH
    PRE = "pre" unless defined? OnePageCRM::Version::PRE

    class << self

      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end
    end
  end
end