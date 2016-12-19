require 'uri'
require 'kinu/configuration'
require 'kinu/version'
require 'kinu/resource'
require 'kinu/sandbox'

module Kinu
  USER_AGENT = "KinuRubyClient/#{Kinu::VERSION}".freeze

  def self.base_uri
    raise "Kinu.config.host is not set." if config.host.empty?
    (config.ssl? ? URI::HTTPS : URI::HTTP).build(host: config.host, port: config.port)
  end

  def self.base_upload_uri
    raise "Kinu.config.upload_host is not set." if config.upload_host.empty?
    (config.ssl? ? URI::HTTPS : URI::HTTP).build(host: config.upload_host, port: config.port)
  end

  def self.configure
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end
end
