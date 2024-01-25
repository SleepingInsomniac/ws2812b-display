require "spi"
require "./panel"

# This requires an SPI adapter for the WS2812b leds.
# The way I acheived this is with a 74LS123 IC "duel retriggerable monostable multivibrators."

device = Spi::Device.new("/dev/spidev0.0")
device.mode = Spi::Mode::MODE_1
device.bits_per_word = 8_u8
device.baud = 800_000_u32 # 1.25 µs per bit

panel = Panel.new(16, 16)
x = 0
y = 0

loop do
  {
    {0xffu8, 0x00u8, 0x00u8},
    {0x00u8, 0xffu8, 0x00u8},
    {0x00u8, 0x00u8, 0xffu8},
  }.each_with_index do |color, i|
    panel[x + i, y] = color
  end

  device.send(panel.pixels)

  sleep 50.0e-6 # Reset signal for new frame is min 50µs
  sleep 0.1

  panel[x, y] = {0x00u8, 0x00u8, 0x00u8}
  panel[x + 1, y] = {0x00u8, 0x00u8, 0x00u8}
  panel[x + 2, y] = {0x00u8, 0x00u8, 0x00u8}

  x += 1

  if x >= panel.width
    x = 0
    y += 1
  end

  if y >= panel.height
    y = 0
  end
end
