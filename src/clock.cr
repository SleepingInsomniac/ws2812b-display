# Draws a simple anolog clock
struct Clock
  HOURS_PER_DAY   = 24
  MINUTES_PER_DAY = HOURS_PER_DAY * 60
  SECONDS_PER_DAY = MINUTES_PER_DAY * 60.0
  TWO_PI          = Math::PI * 2

  property center : Vec(Int32)
  property radius : Int32
  property colors = {
    "outline"     => RGB(UInt8).new(100, 100, 0),
    "ticks"       => RGB(UInt8).new(150, 150, 0),
    "second_hand" => RGB(UInt8).new(0, 0, 255),
    "minute_hand" => RGB(UInt8).new(0, 255, 0),
    "hour_hand"   => RGB(UInt8).new(255, 0, 0),
    "center"      => RGB(UInt8).new(50, 50, 50),
  }

  def initialize(@center, @radius)
  end

  def draw_arm(drawable, rads, length, color)
    vec = ((Vec[0.0, -1.0].rotated(rads) * (@radius * length)) + @center).to_i32
    drawable.draw_line(center, vec, color)
  end

  def draw_to(drawable, time = Time.local)
    # Outline
    drawable.draw_circle(@center, @radius, @colors["outline"])
    drawable.draw_circle(@center, @radius - 1, @colors["outline"])

    # Draw clock ticks
    0.upto(23) do |t|
      vec = Vec[0.0, -1.0].rotated((t / 24) * TWO_PI)
      p1 = ((vec * (@radius * 0.75)) + @center).round.to_i32
      p2 = ((vec * (@radius * (t % 3 == 0 ? 0.65 : 0.75))) + @center).round.to_i32
      drawable.draw_line(p1, p2, @colors["ticks"])
    end

    current_seconds =
      (time.hour * 60 * 60) +
        (time.minute * 60) +
        time.second +
        (time.millisecond / 1000)

    draw_arm(drawable, second_radians(current_seconds), 0.8125, @colors["second_hand"])
    draw_arm(drawable, minute_radians(current_seconds), 0.75, @colors["minute_hand"])
    draw_arm(drawable, hour_radians(current_seconds), 0.625, @colors["hour_hand"])
    drawable.draw_point(@center, @colors["center"])
  end

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  private def second_radians(current_seconds)
    (current_seconds % 60.0) * (TWO_PI / 60.0)
  end

  private def minute_radians(current_seconds)
    (current_seconds / 60.0) * (TWO_PI / 60.0)
  end

  private def hour_radians(current_seconds)
    (current_seconds / (SECONDS_PER_DAY / 2)) * TWO_PI
  end
end
