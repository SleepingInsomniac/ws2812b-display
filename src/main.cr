require "spi"
require "./led_matrix"
require "./color"
require "./bitfont"

# This requires an SPI adapter for the WS2812b leds.
# The way I acheived this is with a 74LS123 IC "duel retriggerable monostable multivibrators."

device = Spi::Device.new("/dev/spidev0.0")
device.mode = Spi::Mode::MODE_1
device.bits_per_word = 8_u8
device.baud = 800_000_u32 # 1.25 µs per bit

panel = LEDMatrix.new

x = 0
y = 0

color = RGB(UInt8).new(0xffu8, 0u8, 0u8)
font = BitFont.new("fonts/pixel")

n = 0

loop do
  0.upto(panel.height - 1) do |y|
    0.upto(panel.width - 1) do |x|
      panel[x, y] = {color.g // 15, color.r // 15, color.b // 15}
    end
  end

  time = Time.local.to_s("%H:%M\n   %S\n%^a")
  font.draw_text(time, panel, 1, 1, RGB(UInt8).new(0xFF, 0, 0))

  device.send(panel.pixels, delay_usecs: 50) # Reset signal for new frame is min 50µs (50.0e-6)
  color = color.rotate(1.0)
  n += 1
end
