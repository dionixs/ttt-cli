class Game
  def initialize
    # игровое поле
    @board = Array.new(9, '-')
    # символ игрока
    @user_sign = nil
    # символ компьютера
    @computer_sign = nil
    # возможные ходы
    @moves = Array(0..8)
    # условие победы
    @condition = 0
    # выигрышные комбинации(матрица решений)
    @win_combinations = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
    ]
  end

  # рисуем игровое поле
  def display_board
    clear
    puts "   a     b     c"
    puts "      |     |     "
    puts "1  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}  "
    puts " _____|_____|_____"
    puts "      |     |     "
    puts "2  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}  "
    puts " _____|_____|_____"
    puts "      |     |     "
    puts "3  #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}  "
    puts "      |     |     "
  end

  # выбор x или o
  def choice_sign
    while @user_sign != 'o' && @user_sign != 'x' && @user_sign != '0'
      puts "Do you want to be X or O?"
      @user_sign = STDIN.gets.strip.downcase
    end

    @user_sign = 'o' if @user_sign == '0'
    @computer_sign = 'o' if @user_sign == 'x'
    @computer_sign = 'x' if @user_sign == 'o'
  end

  # определяем кто ходит первым
  def first_move?
    @user_sign == 'x' ? true : false
  end

  # если игрок ходит первым
  def user_begin
    loop do
      user_move
      display_board
      win?
      break if @condition == 1 || @condition == 2 || @moves == []
      computer_move
      display_board
      win?
      break if @condition == 1 || @condition == 2 || @moves == []
    end
  end

  # если компьютер ходит первым
  def computer_begin
    loop do
      computer_move
      display_board
      win?
      break if @condition == 1 || @condition == 2 || @moves == []
      user_move
      display_board
      win?
      break if @condition == 1 || @condition == 2 || @moves == []
    end
  end

  # получаем ход игрока
  def user_move
    move = nil

    while !(0..8).include?(move)
      puts "What is your move? (1-9)"
      move = STDIN.gets.to_i - 1
    end

    # проверка хода на валидность
    if @moves.include? move
      @moves.delete(move)
      @board[move] = @user_sign if @board[move] == "-"
    else
      return user_move
    end
  end

  # ход компьютера
  def computer_move
    move = rand(0..8)

    # проверка хода на валидность
    if @moves.include? move
      @moves.delete(move)
      @board[move] = @computer_sign if @board[move] == "-"
    else
      return computer_move
    end
  end

  # проверка на выигрыш или на ничью
  def win?
    # проверка с помощью матрицы решений
    @win_combinations.each do |i|
      @condition = 1 if @board[i[0]] == @user_sign && @board[i[1]] == @user_sign && @board[i[2]] == @user_sign
      @condition = 2 if @board[i[0]] == @computer_sign && @board[i[1]] == @computer_sign && @board[i[2]] == @computer_sign
    end

    puts "User Win!" if @condition == 1
    puts "Computer Win!" if @condition == 2
    puts "Draw!" if @moves == [] && @condition == 0
  end

  def clear
    system "clear"
  end
end
