# frozen_string_literal: true

# Класс Judge - судья (проверщик).
class Judge
  attr_accessor :board

  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ].freeze

  def initialize(game)
    @board = game.board.cells
  end

  # основной метод для проверки на выигрыш
  # возвращает true если обнаружена выигрышная комбинация
  def is_combo?(player)
    !winning_combination(player.token).nil?
  end

  private

  # метод который возвращает первую подходящую комбинацию
  # или nil если не было совпадения
  def winning_combination(token)
    WIN_COMBINATIONS.find do |indices|
      # возвращаем значения для соответствующих индексов
      # values_at(*[0,1,2]) => values_at(0,1,2)
      values = @board.values_at(*indices)
      # проверяем, равны ли все значения X или O
      values.all?(token)
    end
  end
end
