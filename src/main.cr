require "spi"
require "pixelfont"

require "./led_matrix"
require "./color"
require "./clock"

include CG2d

# This requires an SPI adapter for the WS2812b leds.
# The way I acheived this is with a 74LS123 IC "duel retriggerable monostable multivibrators."

device = Spi::Device.new("/dev/spidev0.0")
device.mode = Spi::Mode::MODE_1
device.bits_per_word = 8_u8
device.baud = 800_000_u32 # 1.25 µs per bit

font = Pixelfont::Font.new("lib/pixelfont/fonts/pixel-3x5")
clock = Clock.new(Vec[19, 19], 12)

panel = LEDMatrix.new

loop do
  time = Time.local

  0.upto(31) do |y|
    0.upto(31) do |x|
      panel.draw_point(x, y, RGB(UInt8).new(0, 0, 0))
    end
  end

  clock.draw_to(panel, time)

  font.draw(time.to_s("%H:%M:%S"), 1, 1) do |x, y, on|
    panel.draw_point(x, y, RGB(UInt8).new(0, 0, 127)) if on
  end

  font.draw(time.to_s("%a").upcase, 1, font.line_height.to_i32 + 2) do |x, y, on|
    panel.draw_point(x, y, RGB(UInt8).new(0, 0, 127)) if on
  end

  device.send(panel.pixels, delay_usecs: 50) # Reset signal for new frame is min 50µs (50.0e-6)
end
