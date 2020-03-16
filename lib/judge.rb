# frozen_string_literal: true

# Класс Judge - судья (проверщик).
class Judge
  attr_reader :board

  def initialize(game)
    @board = game.board.cells
  end

  def winning_combination?(player)
    winning_diagonal?(player) ||
      winning_horizontal?(player) ||
      winning_vertical?(player)
  end

  def winning_diagonal?(player)
    diagonals.any? do |diagonal|
      diagonal.all? { |cell| cell == player.token }
    end
  end

  def winning_horizontal?(player)
    horizontals.any? do |horizontal|
      horizontal.all? { |cell| cell == player.token }
    end
  end

  def winning_vertical?(player)
    verticals.any? do |vertical|
      vertical.all? { |cell| cell == player.token }
    end
  end

  def diagonals
    [[@board[0], @board[4], @board[8]],
     [@board[2], @board[4], @board[6]]]
  end

  def horizontals
    [[@board[0], @board[1], @board[2]],
     [@board[3], @board[4], @board[5]],
     [@board[6], @board[7], @board[8]]]
  end

  def verticals
    [[@board[0], @board[3], @board[6]],
     [@board[1], @board[4], @board[7]],
     [@board[2], @board[5], @board[8]]]
  end
end
