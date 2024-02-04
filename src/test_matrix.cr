require "colorize"
require "pixelfont"
require "./color"
require "./drawable"

include CG2D

# Requires a truecolor terminal (24bit) like iterm2
#
class TestMatrix
  include Drawable

  def initialize
    @width = 32
    @height = 32
    @data = Slice(UInt8).new(32 * 32 * 3)
  end

  def index(x, y)
    (y * @width + x) * 3
  end

  def []=(x, y, value : Tuple(UInt8, UInt8, UInt8))
    return if x > @width - 1 || y > @height - 1
    offset = index(x, y)
    value.each_with_index { |v, i| @data[offset + i] = v }
  end

  def []=(x, y, color : RGB(UInt8))
    self[x, y] = {color.r, color.g, color.b}
  end

  def draw_point(x, y, color)
    self[x, y] = {color.r, color.g, color.b}
  end

  def draw
    puts '╔' + ("══" * @width) + '╗'
    0.upto(@height - 1) do |y|
      print '║'
      0.upto(@width - 1) do |x|
        index = index(x, y)
        print "██".colorize(@data[index + 1], @data[index], @data[index + 2])
      end
      puts '║'
    end
    puts '╚' + ("══" * @width) + '╝'
  end
end

font_small = Pixelfont::Font.new("lib/pixelfont/fonts/pixel-3x5")
font_med = Pixelfont::Font.new("lib/pixelfont/fonts/pixel-5x7")
panel = TestMatrix.new

time = Time.local
font_small.draw(<<-TEXT, 1, 1) do |x, y, on|
#{time.to_s("%H:%M:%S")}
TEXT
  panel[x, y] = RGB(UInt8).new(0xFF, 0, 0) if on
end

font_med.draw(time.to_s("%a"), 1, font_small.line_height.to_i32 + 2) do |x, y, on|
  panel.draw_point(x, y, RGB(UInt8).new(0xFF, 0xFF, 0)) if on
end

panel.draw_point(17, 17, RGB(UInt8).new(0, 0, 0xFF))
panel.draw_line(0, 5, 32, 10, RGB(UInt8).new(0, 0x88, 0xFF))

panel.draw
