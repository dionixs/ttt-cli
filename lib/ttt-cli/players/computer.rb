# frozen_string_literal: true

module Players
  class Computer < Player
    attr_reader :difficulty

    def initialize(params)
      super(params)
      @name = 'Computer'
      @game = params[:game]
      @board = @game.board
      @enemy = @game.first_player
      @difficulty = @game.difficulty
      @ai = AI.create(@game, @difficulty, self)
    end

    def make_move(board)
      move = position
      sleep 0.5
      board.fill_cell(move, @token) unless board.cell_taken?(move)
    end

    private

    def position
      @ai.move_generate
    end
  end
end
