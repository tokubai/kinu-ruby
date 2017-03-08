module Kinu
  class Geometry
    AVAILABLE_TYPES = {
      width:    :w,
      height:   :h,
      quality:  :q,
      crop:     :c,
      original: :o,
      middle:   :m,
      manual_crop: :mc,
      width_offset: :wo,
      height_offset: :ho,
      crop_width: :cw,
      crop_height: :ch,
      assumption_width: :aw,
    }.freeze

    def initialize(options)
      @options = options
      validate
    end

    def validate
      raise ArgumentError, "required geometry hash." if empty?

      return if !(@options[:width].nil? && @options[:height].nil?)
      return if @options[:middle] == true
      return if @options[:original] == true

      raise ArgumentError, <<-EOS
invalid geometry, geometry must be met least one condition.
- set width or height any numeric.
- set middle true.
- set original true.
      EOS
    end

    def empty?
      @options.empty?
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
