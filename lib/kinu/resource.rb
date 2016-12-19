require 'kinu/geometry'
require 'kinu/resource_base'
require 'kinu/http_client'

module Kinu
  class Resource < ResourceBase
    def upload(file)
      Kinu::HttpClient.multipart_post(
        Kinu.base_upload_uri,
        '/upload',
        {
          name: @name,
          id:   @id,
          image: Kinu::HttpClient::UploadFile.new(file),
        },
      )
      nil
    end

    def attach_from_sandbox(sandbox_id)
      Sandbox.attach(Kinu.base_upload_uri, @name, @id, sandbox_id)
    end
  end
end
