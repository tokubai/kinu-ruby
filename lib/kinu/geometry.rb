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
    }.freeze

    def initialize(options)
      @options = options
    end

    def valid?
      if @options[:width].nil? && @options[:height].nil?
        return false
      end
      true
    end

    def to_s
      geo = []
      @options.each do |key, value|
        geo << "#{AVAILABLE_TYPES[key][:signature]}=#{value}" if AVAILABLE_TYPES[key]
      end
      geo.join(',')
    end
  end
end
