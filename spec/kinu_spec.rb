require 'spec_helper'
require 'uri'

RSpec.describe Kinu do

  before do
    Kinu.class_eval { @config = nil }
  end

  describe '.base_uri' do

    subject { Kinu.base_uri }

    context 'when do not set hostname' do
      it 'raises error' do
        expect { subject }.to raise_error
      end
    end

    context 'when set hostname to host' do
      let(:host) { 'example.com' }

      before do
        Kinu.configure do |config|
          config.host = host
        end
      end

      it 'return http url' do
        is_expected.to eq(URI::HTTP.build(host: host))
      end
    end

    context 'when set hostname to host and ssl enabled' do
      let(:host) { 'example.com' }
      let(:ssl) { true }

      before do
        Kinu.configure do |config|
          config.host = host
          config.ssl = ssl
        end
      end

      it 'returns https url' do
        is_expected.to eq(URI::HTTPS.build(host: host))
      end
    end
  end

  describe '.base_upload_uri' do

    subject { Kinu.base_upload_uri }

    context 'when do not set hostname' do
      it 'raises error' do
        expect { subject }.to raise_error
      end
    end

    context 'when set hostname to host' do
      let(:host) { 'example.com' }

      before do
        Kinu.configure do |config|
          config.host = host
        end
      end

      it 'returns http url' do
        is_expected.to eq(URI::HTTP.build(host: host))
      end
    end

    context 'when set hostname to host and upload_host' do
      let(:host) { 'example.com' }
      let(:upload_host) { 'upload.example.com' }

      before do
        Kinu.configure do |config|
          config.host = host
          config.upload_host = upload_host
        end
      end

      it 'returns http upload url' do
        is_expected.to eq(URI::HTTP.build(host: upload_host))
      end
    end

    context 'when set hostname to uploadhost and ssl enabled' do
      let(:upload_host) { 'upload.example.com' }
      let(:ssl) { true }

      before do
        Kinu.configure do |config|
          config.upload_host = upload_host
          config.ssl = ssl
        end
      end

      it 'returns https url' do
        is_expected.to eq(URI::HTTPS.build(host: upload_host))
      end
    end
  end
end
