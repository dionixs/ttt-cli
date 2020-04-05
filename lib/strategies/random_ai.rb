# frozen_string_literal: true

class RandomAI < AI
  def move_generate
    @board.empty_cells.sample
  end
end
