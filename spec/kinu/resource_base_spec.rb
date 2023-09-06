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

      context 'with manual crop option' do
        let(:height) { 100 }
        let(:width) { 100 }
        let(:width_offset) { 10 }
        let(:height_offset) { 10 }
        let(:crop_width) { 80 }
        let(:crop_height) { 80 }
        let(:assumption_width) { 100 }
        let(:geometry) do
          {
            width: width,
            height: height,
            width_offset: width_offset,
            height_offset: height_offset,
            crop_width: crop_width,
            crop_height: crop_height,
            assumption_width: assumption_width,
          }
        end
        let(:uri) do
          URI::HTTP.build(
            host: hostname,
            path: "/images/#{name}/w=#{width},h=#{height},wo=#{width_offset},ho=#{height_offset},cw=#{crop_width},ch=#{crop_height},aw=#{assumption_width}/#{id}.jpg"
          )
        end

        it 'returns uri' do
          is_expected.to eq(uri)
        end

        context 'with original' do
          let(:geometry) do
            {
              width: width,
              height: height,
              width_offset: width_offset,
              height_offset: height_offset,
              crop_width: crop_width,
              crop_height: crop_height,
              assumption_width: assumption_width,
              original: true,
            }
          end
          let(:uri) do
            URI::HTTP.build(
              host: hostname,
              path: "/images/#{name}/w=#{width},h=#{height},wo=#{width_offset},ho=#{height_offset},cw=#{crop_width},ch=#{crop_height},aw=#{assumption_width},o=true/#{id}.jpg"
            )
          end

          it 'returns uri' do
            is_expected.to eq(uri)
          end
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
