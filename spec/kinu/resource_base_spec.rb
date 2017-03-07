require 'spec_helper'
require 'uri'

module Kinu
  RSpec.describe ResourceBase do
    let(:hostname) { 'example.com' }
    let(:upload_hostname) { 'upload.example.com' }

    before do
      Kinu.configure do |config|
        config.host = hostname
        config.upload_host = upload_hostname
        config.ssl = false
        config.port = 80
      end
    end

    describe '#uri' do
      let(:name) { 'user' }
      let(:id) { 1 }

      subject { Kinu::ResourceBase.new(name, id).uri(geometry) }

      context 'with empty geometry hash' do
        let(:geometry) { Hash.new }

        it 'raises ArgumentError' do
          expect{ subject }.to raise_error(ArgumentError)
        end
      end

      context 'with crop option' do
        let(:geometry) { { crop: true } }

        it 'raises ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'with width' do
        let(:width) { 100 }
        let(:geometry) { { width: width } }
        let(:uri) { URI::HTTP.build(host: hostname, path: "/images/#{name}/w=#{width}/#{id}.jpg") }

        it 'returns uri' do
          is_expected.to eq(uri)
        end
      end

      context 'with height' do
        let(:height) { 100 }
        let(:geometry) { { height: height } }
        let(:uri) { URI::HTTP.build(host: hostname, path: "/images/#{name}/h=#{height}/#{id}.jpg") }

        it 'returns uri' do
          is_expected.to eq(uri)
        end
      end

      context 'with middle' do
        let(:geometry) { { middle: true } }
        let(:uri) { URI::HTTP.build(host: hostname, path: "/images/#{name}/m=true/#{id}.jpg") }

        it 'returns uri' do
          is_expected.to eq(uri)
        end
      end

      context 'with original' do
        let(:geometry) { { original: true } }
        let(:uri) { URI::HTTP.build(host: hostname, path: "/images/#{name}/o=true/#{id}.jpg") }

        it 'returns uri' do
          is_expected.to eq(uri)
        end
      end
    end
  end
end
