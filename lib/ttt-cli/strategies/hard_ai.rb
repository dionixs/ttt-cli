# frozen_string_literal: true

class HardAI < AI
  def move_generate
    if is_first_move?
      @board.even_cells.sample
    else
      minimax(@board, @computer)
      @best_move
    end
  end
end
