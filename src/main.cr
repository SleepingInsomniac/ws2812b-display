require "spi"
require "pixelfont"

require "./led_matrix"
require "./color"

# This requires an SPI adapter for the WS2812b leds.
# The way I acheived this is with a 74LS123 IC "duel retriggerable monostable multivibrators."

device = Spi::Device.new("/dev/spidev0.0")
device.mode = Spi::Mode::MODE_1
device.bits_per_word = 8_u8
device.baud = 800_000_u32 # 1.25 µs per bit

panel = LEDMatrix.new

x = 0
y = 0

n = 0
font = Pixelfont::Font.new("lib/pixelfont/fonts/pixel-3x5")

loop do
  0.upto(31) do |y|
    0.upto(31) do |x|
      color = HSV.new((((x / 32) * 360) + n) % 360, 1.0, 1.0 - (y / 31))
      panel.draw_point(x, y, RGB(UInt8).from_hsv(color))
    end
  end

  n += 0.1

  time = Time.local.to_s("%H:%M:%S\n%^A")

  font.draw(time, 1, 1) do |x, y, on|
    panel.draw_point(x, y, RGB(UInt8).new(0xFF, 0, 0)) if on
  end

  device.send(panel.pixels, delay_usecs: 50) # Reset signal for new frame is min 50µs (50.0e-6)
end
