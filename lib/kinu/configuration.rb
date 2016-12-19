module Kinu
  class Configuration
    attr_writer :host, :upload_host, :port, :ssl

    def host
      @host || ""
    end

    def upload_host
      @upload_host || host || ""
    end

    def port
      if @port
        @port
      elsif ssl?
        443
      else
        80
      end
    end

    def ssl?
      @ssl
    end

    def scheme
      if ssl?
        :https
      else
        :http
      end
    end
  end
end
