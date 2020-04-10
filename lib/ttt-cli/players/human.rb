# frozen_string_literal: true

module Players
  class Human < Player
    def initialize(params)
      super(params)
      @name = params[:name]
      @name = 'Human' unless params[:name]
    end

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
      CommandLine::Display.choose_cell
    end
  end
end
