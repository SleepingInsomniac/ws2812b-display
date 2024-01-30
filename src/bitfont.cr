class BitFont
  struct BitChar
    property bits : UInt64
    property width : UInt8
    property height : UInt8

    def initialize(@bits, @width, @height)
    end
  end

  getter height : UInt8
  getter chars = {} of Char => BitChar

  def initialize(path : String)
    state = :read_char
    char_def = uninitialized Char
    char_width = 0u8
    char_height = 0u8
    char_bits = 0u64
    mask = 1u64 << 63
    @height = 0u8

    File.open(path, "r") do |file|
      while line = file.gets("\n", true)
        case state
        when :read_char
          next if line.blank?
          char_def = line.size > 1 ? line[1] : line[0]
          state = :get_data
        when :get_data
          if line.blank?
            @height = char_height if char_height > @height
            @chars[char_def] = BitChar.new(char_bits, char_width, char_height)
            char_width = 0u8
            char_height = 0u8
            char_bits = 0u64
            mask = 1u64 << 63
            state = :read_char
          else
            char_height += 1
            char_width = line.size.to_u8 if line.size > char_width
            line.chars.each do |char|
              char_bits |= mask if char != '.'
              mask >>= 1
            end
          end
        end
      end

      @chars[char_def] = BitChar.new(char_bits, char_width, char_height)
    end
  end

  # TODO: Consider individual char widths
  def draw_text(msg : String, matrix, x : UInt32 = 0, y : UInt32 = 0, color : RGB(UInt8) = RGB(UInt8).new(0xFFu8, 0xFFu8, 0xFFu8))
    cur_y = 0
    cur_x = 0
    tracking = 1
    leading = 1

    msg.chars.each do |c|
      if c == ' '
        cur_x += 1
        next
      end

      if c == '\n'
        cur_y += 1
        cur_x = 0
        next
      end

      if char = @chars[c]?
        mask = 1_u64 << 63

        0.upto(char.height - 1) do |cy|
          0.upto(char.width - 1) do |cx|
            if mask & char.bits > 0
              matrix[x + cx + (cur_x * (char.width + tracking)), y + cy + (cur_y * (char.height + leading))] = color.to_tuple_grb
            end
            mask >>= 1
          end
        end
      end

      cur_x += 1
    end
  end
end
