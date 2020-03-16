# frozen_string_literal: true

module Players
  class Human < Player
    def initialize(token, _name = nil)
      super(token, name = :human)
    end

    def position
      CommandLine::Display.choose_cell
      CommandLine::Input.get_input.to_i - 1
    end

    def move(player = self, board)
      move = player.position
      if !board.cell_taken?(move)
        board.fill_cell(move, player.token)
      else
        CommandLine::Display.invalid_choice
        player.move(player, board)
      end
    end
  end
end
