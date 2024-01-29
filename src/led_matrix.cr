# Layout is in a reverse z pattern (they chose the worse way possible), 16x16 for each panel.
#
#    0 1 2 3 4 5 6 7 8 9 A B C D E F      0 1 2 3 4 5 6 7 8 9 A B C D E F
#                                    ║ ╔══════════════════════════════════╗
# 0 ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# 1 ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# 2 ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# 3 ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# 4 ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# 5 ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# 6 ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# 7 ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# 8 ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# 9 ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# A ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# B ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# C ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# D ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# E ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# F ╚══════════════════════════════════╝ ║
#                                    ╔═══╝
#                                    ║ ╔══════════════════════════════════╗
# 0 ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# 1 ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# 2 ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# 3 ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# 4 ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# 5 ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# 6 ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# 7 ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# 8 ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# 9 ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# A ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# B ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# C ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# D ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗ ║ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
# E ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝ ║ ╔◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╝
# F ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═══╝ ╚◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═◯═╗
#
class LEDMatrix
  getter panel_width : UInt32 = 16
  getter panel_height : UInt32 = 16
  getter panels_x : UInt32 = 2
  getter panels_y : UInt32 = 2
  getter bytes_per_pixel : UInt32 = 3

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

  def index(x, y)
    x %= @width
    y %= @height

    panel_x, x = x.divmod(@panel_width)
    panel_y, y = y.divmod(@panel_height)

    offset = y * @panel_width
    offset += y.even? ? @panel_width - x - 1 : x

    offset += (panel_y * panels_x + panel_x) * @pixels_per_panel
  end

  def []=(x, y, value : Tuple(UInt8, UInt8, UInt8))
    offset = index(x, y) * @bytes_per_pixel

    value.each_with_index do |v, i|
      @pixels[offset + i] = v
    end
  end

  def [](x, y)
    offset = index(x, y) * @bytes_per_pixel
    @pixels[offset..(offset + 2)]
  end
end
