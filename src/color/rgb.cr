struct RGB(T)
  property r : T
  property g : T
  property b : T

  def initialize(@r, @g, @b)
  end

  def to_hsl
    rp = r / T::MAX
    gp = g / T::MAX
    bp = b / T::MAX

    max = [rp, gp, bp].max
    min = [rp, gp, bp].min
    l = (max + min) / 2.0

    if max == min
      h = s = 0.0
    else
      d = max - min
      s = l > 0.5 ? d / (2.0 - max - min) : d / (max + min)

      h = case max
          when rp then (gp - bp) / d + (gp < bp ? 6.0 : 0)
          when gp then (bp - rp) / d + 2.0
          when b  then (rp - gp) / d + 4.0
          else         0.0
          end

      h /= 6.0
    end

    HSL.new(h, s, l)
  end

  def rotate(angle : Float64)
    to_hsl.rotate(angle).to_rgb8
  end

  def to_tuple_grb
    {@g, @r, @b}
  end
end

alias RGB8 = RGB(UInt8)
