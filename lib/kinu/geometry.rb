module Kinu
  class Geometry
    AVAILABLE_TYPES = {
      width:    :w,
      height:   :h,
      quality:  :q,
      crop:     :c,
      original: :o,
      middle:   :m,
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
      AVAILABLE_TYPES.each do |full_name, short_name|
        next if @options[full_name].nil?
        geo << "#{short_name}=#{@options[full_name]}"
      end
      geo.join(',')
    end
  end
end
