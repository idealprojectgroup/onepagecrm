require 'spec_helper'

describe OnePageCRM::Client do
  subject do
    OnePageCRM::Client.new :login => "login", :password => "password", :uid => "4e5de962638190102c000337", :api_key => "3zc32iOuuXANr9jg/8cB8R89lK9bJWwzTzgr6FNoP88="
  end

  describe "#connection" do
    it "returns a Faraday connection" do
      subject.send(:connection).class.should == Faraday::Connection
    end
  end

  describe "#auth_header" do
    let (:uri) { "/some/uri.json" }

    before do
      Timecop.freeze
    end

    after do
      Timecop.return
    end

    context "when GET or DELETE" do
      before do
        @auth_header = subject.send(:auth_header, :get, uri, "")
      end

      it "calculates correct signature" do
        @auth_header.should == auth_header(:get, "/some/uri.json")
      end
    end

    context "when POST or PUT" do
      before do
        @auth_header = subject.send(:auth_header, :post, uri, "some body")
      end

      it "calculates correct signature with body" do
        @auth_header.should == auth_header(:post, "/some/uri.json", "some body")
      end
    end
  end
end

def auth_header method, path, body=nil
  params = ["4e5de962638190102c000337", Time.now.utc.to_i, method.to_s.upcase, Digest::SHA1.hexdigest(path)]
  params << Digest::SHA1.hexdigest(body) if [:post, :put].include?(method)
  OpenSSL::HMAC.hexdigest("sha256", "3zc32iOuuXANr9jg/8cB8R89lK9bJWwzTzgr6FNoP88=", params.join('.'))
end