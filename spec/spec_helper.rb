require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter
]
SimpleCov.start

require 'onepagecrm'
require 'rspec'
require 'webmock/rspec'

WebMock.disable_net_connect!

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  
end
