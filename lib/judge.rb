# Класс Judge - судья (проверщик).
#
# Проверщик должен содержать метод для определения, что один из игроков победил
# - построил на поле линию из одинаковых символов по вертикали, горизонтали или диагонали.
# Метод принимает объект Board для проверки в аргументах.

class Judge
  attr_accessor :condition

  WIN_COMBINATIONS = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
  ]

  def initialize
    # условие победы
    @condition = 0
  end

  def win?(board, player)
    # проверка с помощью матрицы решений
    WIN_COMBINATIONS.each do |i|
      if board.cells[i[0]] == player.token &&
          board.cells[i[1]] == player.token &&
          board.cells[i[2]] == player.token
        # @condition = 1 if player.is_a?(Players::Human)
        # @condition = 2 if player.is_a?(Players::Computer)
        # @condition = -1 if board.full?
      end
    end
  end
end