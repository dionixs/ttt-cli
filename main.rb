# frozen_string_literal: true

require 'byebug'

require_relative 'lib/command_line/display'
require_relative 'lib/command_line/input'
require_relative 'lib/board'
require_relative 'lib/ai'
require_relative 'lib/player'
require_relative 'lib/players/computer'
require_relative 'lib/players/human'
require_relative 'lib/judge'
require_relative 'lib/game'

# старт
game = Game.start

# определяем кто ходит первым
game.who_goes_first

# чистка экрана
CommandLine::Input.clear
# вывод игрового поля на экран
puts game.board

# основной цикл:
# -- пока поле не заполнилось или один из игроков не победил
loop do
  # ход текущего игрока
  game.current_player.move(game.board)
  # чистка экрана
  CommandLine::Input.clear
  # вывод игрового поля на экран
  puts game.board
  # проверка ситуации на поле
  break if game.over?
  # переключение на следующего игрока
  game.switch_players
end

# вывод сообщения о победе/ничье.
if game.current_player.name == :human && game.draw?
  CommandLine::Display.draw
elsif game.current_player.name == :human && game.won?
  CommandLine::Display.winner
else
  CommandLine::Display.loser
end
