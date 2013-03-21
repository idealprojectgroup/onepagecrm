# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'onepagecrm/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'faraday', ['~> 0.8', '< 0.10']
  spec.add_dependency 'multi_json', '~> 1.0'
  spec.add_development_dependency 'bundler', '~>1.0'
  spec.authors = ["Derek Hopper"]
  spec.description = %q{A Ruby wrapper for the OnePageCRM API.}
  spec.email = ['hopper.derek@gmail.com']
  spec.files = %w(CHANGELOG.md CONTRIBUTING.md LICENSE.md README.md Rakefile onepagecrm.gemspec)
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("spec/**/*")
  spec.homepage = "https://github.com/idealprojectgroup/onepagecrm"
  spec.licenses = ['MIT']
  spec.name = 'onepagecrm'
  spec.require_paths = ['lib']
  spec.required_rubygems_version = '>= 1.3.6'
  spec.signing_key = File.expand_path("~/.gem/private_key.pem") if $0 =~ /gem\z/
  spec.summary = spec.description
  spec.test_files = Dir.glob("spec/**/*")
  spec.version = OnePageCRM::Version
end