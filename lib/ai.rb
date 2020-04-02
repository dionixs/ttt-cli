class AI
  attr_reader :best_move

  def initialize(game, enemy, computer)
    @game = game
    @computer = computer
    @enemy = enemy
    @best_move = nil
  end

  # основная минимакс-функция
  # возвращает значение, если найдено конечное состояние(+10, 0, -10)
  # проходит по всем пустым клеткам на поле
  # вызывает минимакс функцию для каждой из них (рекурсия)
  # оценивает полученные значения
  # и возвращает наилучшее из них
  def minimax(board, player, depth = 0, moves = {})
    # копия доски
    new_board = board.dup
    # индексы свободных клеток
    empty_indices = new_board.empty_cells

    # проверка на терминальное состояние
    return 10 - depth if @game.won?(@computer)
    return (-10) + depth if @game.won?(@enemy)
    return 0 if @game.draw?

    empty_indices.each do |index|
      new_board.fill_cell(index, player.token)
      next_player = opponent(player)
      moves[index] = minimax(new_board, next_player, depth + 1)
      new_board.reset_cell(index)
    end

    # возвращаем наилучшее значение
    minimax_score(moves, player)
  end

  private
  # метод для оценки полученных значений
  # возвращает наилучшее значение
  def minimax_score(moves, player)
    if player.token == @computer.token
      @best_move, best_score = moves.max_by { |_, v| v }
    else
      @best_move, best_score = moves.min_by { |_, v| v }
    end

    best_score
  end

  # метод для выбора оппонента для текущего игрока
  def opponent(player)
    if player.token == @computer.token
      @enemy
    else
      @computer
    end
  end
end
