require 'spec_helper'

module Kinu
  RSpec.describe HttpClient do
    let(:hostname) { 'example.com' }
    let(:base_uri) { "http://#{hostname}" }
    let(:path) { '/upload' }
    let(:request_uri) { "#{base_uri}#{path}" }

    describe '.post' do
      context 'when the server respond 200' do
        let(:headers) { { 'Content-Type': content_type } }
        let(:json) { { name: 'user', id: 1 }.to_json }

        before do
          stub_request(:post, request_uri).
            to_return(status: 200, body: json, headers: headers)
        end

        context 'when respond content type is json' do
          let(:content_type) { 'application/json' }

          it 'returns JSON' do
            expect(HttpClient.post(base_uri, path, {})).to eq(JSON.parse(json))
          end
        end

        context 'when respond content type is txt' do
          let(:content_type) { 'text/plain' }

          it 'return String' do
            expect(HttpClient.post(base_uri, path, {})).to eq(json)
          end
        end
      end

      context 'when the server respond 400 Error' do
        before do
          stub_request(:post, request_uri).to_return(status: 400)
        end

        it 'raises BadRequestError' do
          expect{ HttpClient.post(base_uri, path, {}) }.to raise_error(BadRequestError)
        end
      end

      context 'when the server respond 404 Error' do
        before do
          stub_request(:post, request_uri).to_return(status: 404)
        end

        it 'raises ClientError' do
          expect{ HttpClient.post(base_uri, path, {}) }.to raise_error(ClientError)
        end
      end

      context 'when the server respond 500 Error' do
        before do
          stub_request(:post, 'http://example.com/upload').to_return(status: 500)
        end

        it 'raises ClientError' do
          expect{ HttpClient.post(base_uri, path, {}) }.to raise_error(ServerError)
        end
      end
    end

    describe '.multipart_post' do
      context 'with no params' do
        let(:headers) { { 'Content-Type': content_type } }
        let(:content_type) { 'application/json' }
        let(:json) { { name: 'user', id: 1 }.to_json }

        before do
          stub_request(:post, request_uri).
            to_return(status: 200, body: json, headers: headers)
        end

        it 'returns JSON' do
          HttpClient.multipart_post(base_uri, path, {})
        end
      end

      context 'with a file param' do
        let(:filepath) { Pathname.new(__FILE__).parent.join('onigiri_sake.jpg') }
        let(:file) { File.new(filepath) }
        let(:params) do
          { name: 'User',
            id: 1,
            image: Kinu::HttpClient::UploadFile.new(file)
          }
        end
        let(:headers) { { 'Content-Type': content_type } }
        let(:content_type) { 'application/json' }
        let(:json) { { name: 'user', id: 1 }.to_json }

        before do
          stub_request(:post, request_uri).
            to_return(status: 200, body: json, headers: headers)
        end

        it 'does not raise any errors' do
          expect{
            HttpClient.multipart_post(base_uri, path, params)
          }.to_not raise_error
        end
      end
    end
  end
end
