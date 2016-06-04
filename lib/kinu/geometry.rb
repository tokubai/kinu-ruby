module Kinu
  class Geometry
    AVAILABLE_TYPES = {
      width: {
        signature: :w,
        type:      :integer
      },
      height: {
        signature: :h,
        type:      :integer
      },
      quality: {
        signature: :q,
        type:      :quality,
      },
      crop: {
        signature: :c,
        type:      :bool,
      },
      original: {
        signature: :o,
        type:      :bool,
      },
      middle: {
        signature: :m,
        type:      :integer,
      }
    }.freeze

    def initialize(options)
      @options = options
    end

    def valid?
      return false if @options.empty?
      return false if @options[:width].nil? && @options[:height].nil?
      true
    end

    def to_s
      geo = []
      AVAILABLE_TYPES.each do |key, metadata|
        next if @options[key].nil?
        geo << "#{metadata[:signature]}=#{@options[key]}"
      end
      geo.join(',')
    end
  end
end
