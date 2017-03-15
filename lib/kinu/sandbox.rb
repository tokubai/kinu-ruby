require 'json'
require 'kinu/resource_base'

module Kinu
  class Sandbox < ResourceBase
    def self.upload(file)
      response = Kinu::HttpClient.multipart_post(
        Kinu.base_upload_uri,
        '/sandbox',
        {
          image: Kinu::HttpClient::UploadFile.new(file),
        }
      )
      new(response['id'])
    end

    def self.attach(name, id, sandbox_id)
      response = Kinu::HttpClient.post(
        Kinu.base_upload_uri,
        '/sandbox/attach',
        {
          name: name,
          id:   id,
          sandbox_id: sandbox_id,
        }
      )
      Resource.new(response['name'], response['id'])
    end

    def initialize(id)
      super('__sandbox__', id)
    end

    def attach_to(name, attach_id)
      self.class.attach(name, attach_id, self.id)
    end
  end
end
