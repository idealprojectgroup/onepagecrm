require 'spec_helper'

describe OnePageCRM::API::Authorization do

  before do
    OnePageCRM.configure do |config|
      config.login = "test@example.com"
      config.password = "test123"
      config.uid = "4e5de962638190102c000337"
      config.api_key = "3zc32iOuuXANr9jg/8cB8R89lK9bJWwzTzgr6FNoP88="
    end
    @client = OnePageCRM.client
  end

  describe "#login" do
    before do
      stub_post("/api/auth/login.json").with(:body => {:login => "test@example.com", :password => "test123"}).to_return(:body => fixture("auth_login.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "makes the correct request" do
      @client.login
      expect(a_post("/api/auth/login.json").with(:body => {:login => "test@example.com", :password => "test123"})).to have_been_made
    end

  end

  describe "#logout" do
    before do
      stub_get("/api/auth/logout.json").to_return(:body => fixture("auth_logout.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "makes the correct request" do
      @client.logout
      expect(a_get("/api/auth/logout.json")).to have_been_made
    end
  end
end