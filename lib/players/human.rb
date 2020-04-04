# frozen_string_literal: true

module Players
  class Human < Player
    def make_move(board)
      move = position
      if !board.cell_taken?(move)
        board.fill_cell(move, @token)
      else
        CommandLine::Display.invalid_choice
        make_move(board)
      end
    end

    private

    def position
      CommandLine::Display.choose_cell
      CommandLine::Input.get_input.to_i - 1
    end
  end
end
