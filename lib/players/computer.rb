# frozen_string_literal: true

module Players
  class Computer < Player
    def initialize(token, _name = nil)
      super(token, name = :computer)
    end

    def position
      rand(0..8)
    end

    def move(player = self, board)
      move = player.position
      if !board.cell_taken?(move)
        board.fill_cell(move, player.token)
      else
        player.move(player, board)
      end
    end
  end
end
