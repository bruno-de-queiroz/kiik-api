require 'rubygems'
require 'yaml'
require 'faraday'
require 'json'
require 'hashie'
require 'uri'
require "base64"
require "openssl"
require 'multi_json'
require 'multi_xml'
require 'rack'

require 'kiik/errors'
require 'kiik/logger'
require 'kiik/client'
require 'kiik/response'
require 'kiik/wallet'
require 'kiik/wallet/client'
require 'kiik/wallet/user'
require 'kiik/wallet/creditcard'

module Kiik
  # set a default
  @config_path = defined?(Rails) ? File.join(Rails.root , 'config' , 'kiik.yml') : 'kiik.yml'

  class << self  
    attr_accessor :config_path
  end
 
  def self.config
    @config ||= load_config
  end

  def self.wallet
    @wallet ||= Kiik::Wallet.new(config[:token],config[:wallet])
    @wallet.api
  end

  def self.load_config
    unless File.file?(config_path)
      raise NotConfigured.new("The #{file} config file is missing.")
    end
 
    cfg = YAML.load_file(config_path)
    raise NoAuthorizationTokenProvided.new("You will need a authorization token to perform request on kiik api") if cfg[:token].nil?
    cfg
  end

end
