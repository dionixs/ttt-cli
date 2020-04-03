# frozen_string_literal: true

require 'byebug'

require_relative 'lib/emoji'
require_relative 'lib/cli/display'
require_relative 'lib/cli/input'
require_relative 'lib/board'
require_relative 'lib/ai'
require_relative 'lib/player'
require_relative 'lib/players/computer'
require_relative 'lib/players/human'
require_relative 'lib/judge'
require_relative 'lib/game'

# Cтарт новой игры:
# - Выводим приветственный текст
# - Устанавливаем символы игрокам
# - Определяем кто ходит первым
# - Выводим игровое поле на экран
game = Game.start

# основной цикл:
# -- пока поле не заполнилось или один из игроков не победил
loop do
  # ход текущего игрока
  game.current_player.move(game.board)
  # вывод игрового поля на экран
  CommandLine::Display.print_board(game.board)

  # проверка ситуации на поле
  if game.over?
    # вывод сообщения о победе/ничье.
    game.over_message
    # спрашиваем игрока, хочет ли он сыграть еще
    if game.start_new_game? # todo
      game = Game.start
      next
    else
      exit
    end
  end

  # переключение на следующего игрока
  game.switch_player
end
