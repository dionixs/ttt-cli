# frozen_string_literal: true

require 'byebug'

require_relative 'lib/cli/display'
require_relative 'lib/cli/input'
require_relative 'lib/board'
require_relative 'lib/ai'
require_relative 'lib/player'
require_relative 'lib/players/computer'
require_relative 'lib/players/human'
require_relative 'lib/judge'
require_relative 'lib/game'

# старт
game = Game.start

# игровое поле
board = game.board

# определяем кто ходит первым
game.who_goes_first

# вывод игрового поля на экран
CommandLine::Display.print_board(board)

# основной цикл:
# -- пока поле не заполнилось или один из игроков не победил
loop do
  # ход текущего игрока
  game.current_player.move(board)
  # вывод игрового поля на экран
  CommandLine::Display.print_board(board)
  # проверка ситуации на поле
  break if game.over?

  # переключение на следующего игрока
  game.switch_players
end

# вывод сообщения о победе/ничье.
game.over_message
