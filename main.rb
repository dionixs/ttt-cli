require_relative 'lib/command_line/display'
require_relative 'lib/command_line/input'
require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/players/computer'
require_relative 'lib/players/human'
require_relative 'lib/judge'
require_relative 'lib/game'

# старт
game = Game.start

# определяем кто ходит первым
game.who_goes_first

# чистим экран
CommandLine::Input.clear

# показываем пустое игровое поле
CommandLine::Display.empty_board

# основной цикл:
# -- пока поле не заполнилось или один из игроков не победил
loop do
  # ход первого игрока
  game.make_move(game.first_player)
  # проверка на победу
  game.judge.win?(game.board, game.first_player)
  # break if game.judge.condition == 1 ||
  #     game.judge.condition == 2 ||
  #     game.judge.condition == -1
  # вывод игрового поля на экран
  puts game.board

  # чистим экран
  CommandLine::Input.clear

  # ход второго игрока
  game.make_move(game.second_player)
  # проверка на победу
  game.judge.win?(game.board, game.second_player)
  # break if game.judge.condition == 1 ||
  #     game.judge.condition == 2 ||
  #     game.judge.condition == -1
  # вывод игрового поля на экран
  puts game.board
end

# вывод сообщения о победе/ничье.
#
# спросить у игрока, будет ли он играть снова
#
# конец
