# frozen_string_literal: true

module Players
  class Human < Player
    def make_move(board)
      move = position
      if !board.cell_taken?(move)
        board.fill_cell(move, @token)
      else
        make_move(board)
      end
    end

    private

    def position
      index = CommandLine::Display.choose_cell
      index.to_i - 1
    end
  end
end
