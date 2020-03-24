# frozen_string_literal: true

module Players
  class Human < Player
    def initialize(params)
      super(params)
      @name = :human
    end

    def position
      CommandLine::Display.choose_cell
      CommandLine::Input.get_input.to_i - 1
    end

    def move(board)
      move = position
      if !board.cell_taken?(move)
        board.fill_cell(move, @token)
      else
        CommandLine::Display.invalid_choice
        self.move(board)
      end
    end
  end
end
