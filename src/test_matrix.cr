require "colorize"
require "./bitfont"
require "./color"

class TestMatrix
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

font_small = BitFont.new("fonts/pixel-small")
font_med = BitFont.new("fonts/pixel")
panel = TestMatrix.new

time = Time.local
font_small.draw_text(<<-TEXT, panel, 1, 1, RGB(UInt8).new(0xFF, 0, 0))
#{time.to_s("%H:%M:%S")}
TEXT
font_med.draw_text(time.to_s("\n%a"), panel, 1, 1, RGB(UInt8).new(0xFF, 0xFF, 0))

panel.draw
