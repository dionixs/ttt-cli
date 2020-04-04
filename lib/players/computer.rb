# frozen_string_literal: true

module Players
  class Computer < Player
    attr_accessor :difficulty

    # todo
    def initialize(params)
      super(params)
      @game = params[:game]
      @board = @game.board
      @enemy = @game.human
      @difficulty = @game.difficulty
      @ai = AI.create(@game, @enemy, self, @difficulty)
    end

    def make_move(board)
      move = position
      board.fill_cell(move, @token) unless board.cell_taken?(move)
    end

    private

    # todo
    def position
      if @difficulty != HardAI
        @ai.move_generate(@board)
      else
        @ai.minimax(@board, self)
        @ai.best_move
      end
    end
  end
end


# module Players
#   class Computer < Player
#     def initialize(params)
#       super(params)
#       @game = params[:game]
#       @board = @game.board
#       @enemy = @game.human
#       @difficulty = @game.difficulty
#       @ai = AI.new(@game, @enemy, self)
#     end
#

#
#     def position
#       # @board.empty_cells.sample
#       if @board.empty_cells.size == 9
#         @board.even_cells.sample
#       elsif @board.empty_cells.size == 8
#         @board.even_cells.sample
#       else
#         @ai.minimax(@board, self)
#         @ai.best_move
#       end
#     end
#
#     def move(board)
#       index = position
#       board.fill_cell(index, @token) unless board.cell_taken?(index)
#     end
#   end
# end
