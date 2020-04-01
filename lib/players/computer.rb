# frozen_string_literal: true

module Players
  class Computer < Player
    def initialize(params)
      super(params)
      @game = params[:game]
      @name = :computer
      @board = @game.board
      @ai = AI.new(@game, @enemy, self)
    end

    def position
      @ai.minimax(@board, self)
      @ai.best_move
      # @board.empty_cells.sample
    end

    def move(board)
      move = position
      if !board.cell_taken?(move)
        board.fill_cell(move, @token)
      end
    end
  end
end
