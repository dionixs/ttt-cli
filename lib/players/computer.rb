# frozen_string_literal: true

module Players
  class Computer < Player
    attr_reader :difficulty

    def initialize(params)
      super(params)
      @game = params[:game]
      @board = @game.board
      @enemy = @game.human
      @difficulty = @game.difficulty
      @ai = AI.create(@game, @difficulty, self)
    end

    def make_move(board)
      move = position
      board.fill_cell(move, @token) unless board.cell_taken?(move)
    end

    private

    def position
      @ai.move_generate
    end
  end
end
