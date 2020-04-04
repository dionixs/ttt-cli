# frozen_string_literal: true

class AI
  attr_accessor :best_move

  def self.create(game, enemy, computer, type)
    type.new(game, enemy, computer)
  end

  def initialize(game, enemy, computer)
    @game = game
    @computer = computer
    @enemy = enemy
    @best_move = nil
  end

  def move_generate(board); end
end
