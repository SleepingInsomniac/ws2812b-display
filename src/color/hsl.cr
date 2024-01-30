struct HSL
  property h : Float64
  property s : Float64
  property l : Float64

  def initialize(@h, @s, @l)
  end

  def to_rgb8
    if @s == 0.0
      r = g = b = @l # achromatic
    else
      q = @l < 0.5 ? @l * (1.0 + @s) : @l + @s - @l * @s
      p = 2.0 * @l - q

      r = hue_to_rgb(p, q, h + 1.0/3.0)
      g = hue_to_rgb(p, q, h)
      b = hue_to_rgb(p, q, h - 1.0/3.0)
    end

    RGB(UInt8).new((r * 255.0).to_u8, (g * 255.0).to_u8, (b * 255.0).to_u8)
  end

  private def hue_to_rgb(p, q, t)
    t += 1.0 if t < 0.0
    t -= 1.0 if t > 1.0
    return p + (q - p) * 6.0 * t if t < 1.0 / 6.0
    return q if t < 1.0 / 2.0
    return p + (q - p) * (2.0 / 3.0 - t) * 6.0 if t < 2.0 / 3.0
    p
  end

  def rotate(angle : Float64)
    HSL.new((@h + angle / 360.0) % 1.0, @s, @l)
  end
end
