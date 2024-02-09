module CG2D
  struct Circle(T)
    property center : Vec(T)
    property radius : T

    def initialize(@center : Vec(T), @radius : T)
    end
  end
end
