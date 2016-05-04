module Kinu
  class BadRequestError < StandardError
    def initialize(response)
      @response = response
      @status = response.status
      super(response.headers['x-kinu-badrequest-reason'])
    end
  end

  class HttpError < StandardError
    attr_reader :status, :response

    def initialize(response)
      @response = response
      @status = response.status
      super("status: #{status}, response: #{response.body}")
    end
  end
  class ServerError < HttpError; end
  class ClientError < HttpError; end
end
