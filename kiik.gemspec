# -*- encoding: utf-8 -*-
require File.expand_path('../lib/kiik/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "kiik"
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
    ".bundle/config",
    "Manifest",
    "README",
    "Rakefile",
    "kiik.gemspec",
    "lib/kiik.rb",
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
    "specs/lib/kiik/wallet_client_spec.rb",
    "specs/lib/kiik/wallet_client_user_spec.rb",
    "specs/spec_helper.rb"

  ]
  s.homepage = "http://github.com/creativelikeadog/kiik"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "0.0.1"
  s.summary = "A Gem for Kiik API"

  s.add_dependency "hashie"
  s.add_dependency "faraday"
  s.add_dependency "json"
  s.add_dependency "i18n"
  s.add_dependency "rake"
  s.add_dependency "bundler"
  s.add_dependency "fakeweb"
  s.add_dependency "rspec"
  s.add_dependency "simplecov"
  s.add_dependency "rdoc"
  s.add_dependency 'multi_json'
  s.add_dependency 'multi_xml'
  s.add_dependency 'rack'

end

