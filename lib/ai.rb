# frozen_string_literal: true

class AI
  def self.create(game, type, computer)
    type.new(game, computer)
  end

  def initialize(game, computer)
    @game = game
    @board = game.board
    @computer = computer
    @enemy = @game.human
  end

  # Метод для генерации хода AI
  def move_generate; end
end
