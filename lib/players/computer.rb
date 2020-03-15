module Players
  class Computer < Player
    def move
      rand(0..8)
    end
  end
end