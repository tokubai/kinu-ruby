require 'kinu/configuration'
require 'kinu/version'
require 'kinu/resource'
require 'kinu/sandbox'

module Kinu
  USER_AGENT = "KinuRubyClient/#{Kinu::VERSION}"

  def self.base_uri
    URI::HTTP.build(scheme: config.scheme, host: config.host, port: config.port)
  end

  def self.configure
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end
end
