require 'faraday'
require 'kinu/errors'

module Kinu
  class HttpClient
    def self.post(base_uri, path, params)
      new(base_uri, :post, path, params).run
    end

    def self.multipart_post(base_uri, path, params)
      new(base_uri, :post, path, params, multipart: true).run
    end

    def initialize(base_uri, method, path, params, multipart: false)
      @base_uri = base_uri
      @method = method
      @path = path
      @params = params
      @multipart = multipart
    end

    def run
      response = connection.send(@method, @path, @params, "User-Agent" => Kinu::USER_AGENT)
      case response.status
      when 400
        raise BadRequestError.new(response)
      when 400...500
        raise ClientError.new(response)
      when 500...600
        raise ServerError.new(response)
      end

      case response.headers['content-type']
      when 'application/json'
        JSON.parse(response.body)
      else
        response.body
      end
    end

    private

    def connection
      Faraday::Connection.new(@base_uri) do |builder|
        builder.request :multipart if @multipart
        builder.request :url_encoded
        builder.adapter :net_http
      end
    end

    class UploadFile
      def initialize(file)
        @file = file
      end

      def content_type
        case File.extname(@file.path)
        when '.jpg', '.jpeg'
          'image/jpeg'
        when '.png'
          'image/png'
        when '.gif'
          'image/gif'
        else
          'application/octet-stream'
        end
      end

      def original_filename
        File.basename(@file.path)
      end

      def respond_to?(name)
        io.respond_to?(name)
      end

      def method_missing(*args)
        io.send(*args)
      end

      def io
        @io ||= Faraday::UploadIO.new(@file, content_type, original_filename)
      end
    end
  end
end
