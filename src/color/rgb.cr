struct RGB(T)
  property r : T
  property g : T
  property b : T

  def self.from_hsv(hsv : HSV)
    from_hsv(hsv.h, hsv.s, hsv.v)
  end

  def self.from_hsv(h, s, v)
    c = v * s
    x = c * (1 - ((h / 60.0) % 2 - 1).abs)
    m = v - c

    r, g, b =
      case h
      when 0...60    then {c, x, 0}
      when 60...120  then {x, c, 0}
      when 120...180 then {0, c, x}
      when 180...240 then {0, x, c}
      when 240...300 then {x, 0, c}
      else
        {c, 0, x}
      end

    r = T.new(((r + m) * T::MAX).clamp(0, T::MAX))
    g = T.new(((g + m) * T::MAX).clamp(0, T::MAX))
    b = T.new(((b + m) * T::MAX).clamp(0, T::MAX))

    RGB(T).new(r, g, b)
  end

  def initialize(@r : T, @g : T, @b : T)
  end

  def to_hsv
    rgb = {@r / T::MAX, @g / T::MAX, @b / T::MAX}
    max = rgb.max
    min = rgb.min
    delta = max - min

    hue = 0.0
    sat = 0.0
    val = max

    if delta != 0.0
      sat = delta / max

      hue = if r == max
              (rgb[1] - rgb[2]) / delta
            elsif g == max
              2.0 + (rgb[2] - rgb[0]) / delta
            else
              4.0 + (rgb[0] - rgb[1]) / delta
            end

      hue *= 60.0
      hue += 360.0 if hue < 0.0
    end

    HSV.new(hue, sat, val)
  end

  def rotate(degrees : Float)
    h, s, v = to_hsv
    h = (h + degrees) % 360.0
    RGB(T).from_hsv(h, s, v)
  end
end
