require_relative 'lib/game'

game = Game.new
# рисуем игровое поле
game.display_board
# выбор x или 0
game.choice_sign

# определяем кто ходит первым
game.user_begin if game.first_move? == true
game.computer_begin if game.first_move? == false
