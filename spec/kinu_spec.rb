require 'spec_helper'
require 'uri'

RSpec.describe Kinu do

  before do
    Kinu.class_eval { @config = nil }
  end

  describe '.base_uri' do

    subject { Kinu.base_uri }

    context 'when configure empty hostname' do
      it 'raises error' do
        expect { subject }.to raise_error
      end
    end

    context 'when configure hostname' do
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

    context 'when configure hostname and ssl' do
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
end
