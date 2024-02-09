# Draws a simple anolog clock
struct Clock
  HOURS_PER_DAY   = 24
  MINUTES_PER_DAY = HOURS_PER_DAY * 60
  SECONDS_PER_DAY = MINUTES_PER_DAY * 60.0
  TWO_PI          = Math::PI * 2

  property center : Vec(Int32)
  property radius : Int32

  def initialize(@center, @radius)
  end

  def draw_to(drawable, time : Time)
    # Outline
    drawable.draw_circle(@center, @radius, RGB(UInt8).new(100, 100, 0))
    drawable.draw_circle(@center, @radius - 1, RGB(UInt8).new(100, 100, 0))

    # Draw clock ticks
    0.upto(11) do |t|
      vec = Vec[0.0, -1.0].rotated((t / 12) * TWO_PI)
      p1 = ((vec * (@radius * 0.75)) + @center).round.to_i32
      p2 = ((vec * (@radius * 0.7)) + @center).round.to_i32
      drawable.draw_line(p1, p2, RGB(UInt8).new(150, 150, 0))
    end

    current_seconds = (time.hour * 60 * 60) + (time.minute * 60) + time.second + (time.millisecond / 1000)

    # Second hand
    rads = (current_seconds % 60.0) * (TWO_PI / 60.0)
    vec = ((Vec[0.0, -1.0].rotated(rads) * (@radius * 0.8125)) + @center).to_i32
    drawable.draw_line(center, vec, RGB(UInt8).new(0, 0, 255))

    # Minute hand
    rads = (current_seconds / 60.0) * (TWO_PI / 60.0)
    vec = ((Vec[0.0, -1.0].rotated(rads) * (@radius * 0.75)) + @center).to_i32
    drawable.draw_line(center, vec, RGB(UInt8).new(0, 255, 0))

    # Hour hand
    rads = (current_seconds / (SECONDS_PER_DAY / 2)) * TWO_PI
    vec = ((Vec[0.0, -1.0].rotated(rads) * (@radius * 0.625)) + @center).to_i32
    drawable.draw_line(center, vec, RGB(UInt8).new(255, 0, 0))
  end
end
