class RandomAI < AI
  def move_generate(board)
    board.empty_cells.sample
  end
end