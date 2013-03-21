require 'spec_helper'

describe OnePageCRM do
  describe ".client" do
    it "returns a OnePageCRM::Client" do
      OnePageCRM.client.should be_a OnePageCRM::Client
    end
  end

  describe ".configure" do
    OnePageCRM::Configurable.keys.each do |key|
      it "sets the #{key.to_s}" do
        OnePageCRM.configure do |config|
          config.send("#{key}=", key)
        end
        OnePageCRM.instance_variable_get(:"@#{key}").should eq(key)
      end
    end
  end
end