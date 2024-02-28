require "colorize"
require "pixelfont"
require "png"

require "./color"
require "./cg2d"
require "./clock"

include CG2d

# Requires a truecolor terminal (24bit) like iterm2
#
class TestMatrix
  include CG2d::Drawable

  def initialize
    @width = 32
    @height = 32
    @data = Slice(UInt8).new(32 * 32 * 3)

    print "\033[2J"   # Clear
    print "\033[?25l" # Cursor off
    Signal::INT.trap do
      print "\033[?25h" # Cursor on
      exit 127
    end
    at_exit { print "\033[?25h" }
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
    print "\e[1;1H" # Cursor to 1,1
    puts '╔' + ("══" * @width) + '╗'
    0.upto(@height - 1) do |y|
      print '║'
      0.upto(@width - 1) do |x|
        index = index(x, y)
        print "██".colorize(@data[index], @data[index + 1], @data[index + 2])
      end
      puts '║'
    end
    puts '╚' + ("══" * @width) + '╝'
    sleep 0.1
  end
end

canvas = PNG.read("starry-night.png")
panel = TestMatrix.new
font_small = Pixelfont::Font.new("lib/pixelfont/fonts/pixel-3x5")
font_med = Pixelfont::Font.new("lib/pixelfont/fonts/pixel-5x7")
clock = Clock.new(Vec[19, 19], 12)

loop do
  time = Time.local

  0.upto(31) do |y|
    0.upto(31) do |x|
      r, g, b = canvas[x, y]
      panel.draw_point(x, y, RGB(UInt8).new(r, g, b))
      # panel.draw_point(x, y, RGB(UInt8).new(0, 0, 0))
    end
  end

  clock.draw_to(panel, time)

  font_small.draw(time.to_s("%H:%M:%S"), 1, 1) do |x, y, on|
    panel.draw_point(x, y, RGB(UInt8).new(0, 0, 127)) if on
  end

  font_small.draw(time.to_s("%a").upcase, 1, font_small.line_height.to_i32 + 2) do |x, y, on|
    panel.draw_point(x, y, RGB(UInt8).new(0, 0, 127)) if on
  end

  panel.draw
end
