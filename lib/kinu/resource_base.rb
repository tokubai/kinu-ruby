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
      geometry_hash  = options
      build_uri(geometry_hash, format, timestamp)
    end

    def path(options)
      format         = (options.delete(:format) || :jpg)
      geometry_hash  = options
      build_path(geometry_hash, format)
    end

    private

    def build_path(geometry_hash, format)
      "/images/#{@name}/#{Geometry.new(geometry_hash)}/#{@id}.#{format}"
    end

    def build_uri(geometry_hash, format, timestamp)
      uri = base_uri
      uri.path  = build_path(geometry_hash, format)
      uri.query = "#{timestamp.to_s}" if timestamp
      uri
    end

    def base_uri
      Kinu.base_uri
    end
  end
end
