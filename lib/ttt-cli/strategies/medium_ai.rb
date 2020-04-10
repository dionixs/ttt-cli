# frozen_string_literal: true

class MediumAI < AI
  def move_generate
    if is_first_move?
      @board.empty_cells.sample
    else
      minimax(@board, @computer)
      @best_move
    end
  end
end
