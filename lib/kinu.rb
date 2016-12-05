require 'uri'
require 'kinu/configuration'
require 'kinu/version'
require 'kinu/resource'
require 'kinu/sandbox'

module Kinu
  USER_AGENT = "KinuRubyClient/#{Kinu::VERSION}".freeze

  def self.base_uri
    raise "Kinu.config.host is not set." if config.host.empty?
    URI::Generic.build(scheme: config.scheme.to_s, host: config.host, port: config.port).to_s
  end

  def self.configure
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end
end
