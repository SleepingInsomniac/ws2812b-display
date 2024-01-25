class Panel
  getter width : UInt32
  getter height : UInt32
  property pixels : Slice(UInt8)

  def initialize(@width, @height)
    @pixels = Slice(UInt8).new(@width * @height * 3)
  end

  def index(x, y)
    x = @width - 1 if x >= @width

    y = @height - y - 1
    base_index = if y % 2 == 0
                   y * @width + x
                 else
                   (y + 1) * @width - x - 1
                 end
    base_index * 3
  end

  def []=(x, y, value : Tuple(UInt8, UInt8, UInt8))
    value.each_with_index do |v, i|
      @pixels[index(x, y) + i] = v
    end
  end

  def to_unsafe
    @pixels.to_unsafe
  end
end
