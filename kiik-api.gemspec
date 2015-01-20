# -*- encoding: utf-8 -*-
require File.expand_path("../lib/kiik/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "kiik-api"
  s.version = Kiik::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bruno de Queiroz"]
  s.date = "2012-12-24"
  s.description = "A Gem for Kiik API"
  s.email = "creativelikeadog@gmail.com"

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.files = [
    "Manifest",
    "README.md",
    "Rakefile",
    "kiik-api.gemspec",
    "lib/kiik-api.rb",
    "lib/kiik/cacert.pem",
    "lib/kiik/client.rb",
    "lib/kiik/errors.rb",
    "lib/kiik/logger.rb",
    "lib/kiik/response.rb",
    "lib/kiik/version.rb",
    "lib/kiik/wallet.rb",
    "lib/kiik/wallet/client.rb",
    "lib/kiik/wallet/creditcard.rb",
    "lib/kiik/wallet/transaction.rb",
    "lib/kiik/wallet/user.rb",
    "spec/lib/kiik/wallet_client_spec.rb",
    "spec/lib/kiik/wallet_client_user_spec.rb",
    "spec/spec_helper.rb"

  ]
  s.homepage = "http://github.com/creativelikeadog/kiik-api"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "0.1.0"
  s.summary = "A Gem for Kiik API"

  s.add_dependency "activesupport", "= 4.1.8"
  s.add_dependency "hashie", "= 3.3.2"
  s.add_dependency "faraday", "= 0.9.1"
  s.add_dependency "json", "~> 1.8.0"
  s.add_dependency "i18n", "= 0.7.0"
  s.add_dependency "rake", "= 10.4.2"
  s.add_dependency "bundler", "~> 1.0"
  s.add_dependency "fakeweb", "= 1.3.0"
  s.add_dependency "rspec", "~> 3.0", ">= 3.0.0"
  s.add_dependency "simplecov", "= 0.9.1"
  s.add_dependency "rdoc", "~> 4.0"
  s.add_dependency "multi_json", "= 1.3.0"
  s.add_dependency "multi_xml", "= 0.5.5"
  s.add_dependency "rack", "~> 1.5.2"

end

