class AI
  attr_accessor :best_move

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
  def minimax(board, player, depth = 0, score = {})
    # копия доски
    new_board = board.dup
    # индексы свободных клеток
    empty_indices = new_board.empty_cells

    return 10 - depth if @game.won?(@computer)
    return -10 + depth if @game.won?(@enemy)
    return 0 if empty_indices.empty?

    empty_indices.each do |index|
      new_board.fill_cell(index, player.token)
      next_player = opponent(player)
      score[index] = minimax(new_board, next_player, depth + 1)
      new_board.reset_cell(index)
    end

    best_score = 0

    if player.token == @computer.token
      @best_move, best_score = score.max_by { |_, v| v }
    else
      @best_move, best_score = score.min_by { |_, v| v }
    end

    best_score
  end

  # метод для проверки на терминальное состояние:
  # победа (10) / поражение (-10) / ничья (0)
  def score(game, depth)
    if game.won?(@computer)
      10 - depth
    elsif game.won?(@enemy)
      -10 + depth
    else
      0
    end
  end

  # todo
  def opponent(player)
    if player.token == @computer.token
      @enemy
    else
      @computer
    end
  end
end