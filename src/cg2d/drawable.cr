module CG2d::Drawable
  # To be implemented by the including class
  abstract def draw_point(x, y, color)

  def draw_point(point : CG2d::Vec, color)
    draw_point(point.x, point.y, color)
  end
end

require "./drawable/draw_line"
require "./drawable/draw_circle"
