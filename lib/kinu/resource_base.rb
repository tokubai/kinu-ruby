require 'kinu/geometry'
require 'kinu/http_client'

module Kinu
  class ResourceBase
    attr_reader :name, :id

    def initialize(name, id)
      @name, @id = name, id
    end

    def uri(options)
      timestamp      = options.delete(:timestamp)
      format         = (options.delete(:format) || :jpg)
      geometry       = Geometry.new(options)
      build_uri(geometry, format, timestamp)
    end

    def path(options)
      format         = (options.delete(:format) || :jpg)
      geometry       = Geometry.new(options)
      build_path(geometry, format)
    end

    private

    def build_path(geometry, format)
      "/images/#{@name}/#{geometry}/#{@id}.#{format}"
    end

    def build_uri(geometry, format, timestamp)
      uri = base_uri
      uri.path  = build_path(geometry, format)
      uri.query = "#{timestamp.to_s}" if timestamp
      uri
    end

    def base_uri
      Kinu.base_uri
    end
  end
end
