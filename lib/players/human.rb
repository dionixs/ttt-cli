module Players
  class Human < Player
    def move
      CommandLine::Display.choose_cell
      CommandLine::Input.get_input.to_i - 1
    end
  end
end