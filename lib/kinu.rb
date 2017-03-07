require 'uri'
require 'kinu/configuration'
require 'kinu/version'
require 'kinu/resource'
require 'kinu/sandbox'

module Kinu
  USER_AGENT = "KinuRubyClient/#{Kinu::VERSION}".freeze

  def self.base_uri
    raise "Kinu.config.host is not set." unless config.host
    http_class.build(host: config.host, port: config.port)
  end

  def self.base_upload_uri
    host = config.upload_host || config.host
    raise "Kinu.config.upload_host and Kinu.config.upload_host is not set. Please set one or the other." unless host
    http_class.build(host: host, port: config.port)
  end

  def self.configure
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end

  private

  def self.http_class
    config.ssl? ? URI::HTTPS : URI::HTTP
  end
end
