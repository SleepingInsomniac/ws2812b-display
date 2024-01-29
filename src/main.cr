require "spi"
require "./led_matrix"
require "./color"

# This requires an SPI adapter for the WS2812b leds.
# The way I acheived this is with a 74LS123 IC "duel retriggerable monostable multivibrators."

device = Spi::Device.new("/dev/spidev0.0")
device.mode = Spi::Mode::MODE_1
device.bits_per_word = 8_u8
device.baud = 800_000_u32 # 1.25 µs per bit

panel = LEDMatrix.new

# 0.upto(panel.height - 1) do |y|
#   0.upto(panel.width - 1) do |x|
#     panel[x, y] = {x.to_u8, y.to_u8, 0x00u8}
#   end
# end
#
# device.send(panel.pixels)

x = 0
y = 0

color = RGB(UInt8).new(0xffu8, 0u8, 0u8)

loop do
  0.upto(panel.height - 1) do |y|
    0.upto(panel.width - 1) do |x|
      panel[x, y] = {color.g // 2, color.r // 2, color.b // 2}
    end
  end

  device.send(panel.pixels)
  color = color.rotate(2.0)

  sleep 50.0e-6 # Reset signal for new frame is min 50µs

  # sleep 50.0e-6 # Reset signal for new frame is min 50µs
  #
  # x += 1
  #
  # if x > panel.width
  #   x = 0
  #   y += 1
  # end
  #
  # if y > panel.height
  #   y = 0
  # end
end
