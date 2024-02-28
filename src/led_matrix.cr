require "./cg2d"
require "./layout"

class LEDMatrix
  include Layout::Z4
  include CG2d::Drawable

  getter pixels : Slice(UInt8)
  getter pixels_per_panel : UInt32
  getter width : UInt32
  getter height : UInt32

  def initialize
    @pixels_per_panel = @panel_width * @panel_height
    @width = @panel_width * @panels_x
    @height = @panel_height * @panels_y

    @pixels = Slice(UInt8).new(@width * @height * @bytes_per_pixel)
  end

  def to_unsafe
    @pixels.to_unsafe
  end

  def []=(x, y, value : Tuple(UInt8, UInt8, UInt8))
    return unless x < @width && y < @height
    offset = index(x, y) * @bytes_per_pixel

    value.each_with_index do |v, i|
      @pixels[offset + i] = v
    end
  end

  def [](x, y)
    offset = index(x, y) * @bytes_per_pixel
    @pixels[offset..(offset + 2)]
  end

  # Implements `Drawable`
  #
  def draw_point(x, y, color)
    # LEDs are in GRB format
    self[x, y] = {color.g, color.r, color.b}
  end
end
