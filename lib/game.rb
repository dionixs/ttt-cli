# frozen_string_literal: true

# Класс Game: Управляет игровым процессом
class Game
  attr_reader :board, :current_player

  def self.start
    CommandLine::Display.welcome_banner
    new(CommandLine::Input.players_tokens)
  end

  def initialize(tokens)
    @board = Board.new
    @tokens = tokens
    @human = Players::Human.new(@tokens[0])
    @computer = Players::Computer.new(@tokens[1])
    @first_player = @human
    @second_player = @computer
    @current_player = @human
    @judge = Judge.new(self)
  end

  # Метод для выбора игрока, который будет ходить первым.
  #
  # По умолчанию первым ходит игрок.
  #
  # Если игрок выбрал "O", данный метод изменит порядок игроков.
  def who_goes_first
    if @tokens[0] != 'X'
      @first_player = @computer
      @second_player = @human
    end
  end

  # Метод для переключения на следующего игрока
  def switch_players
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end

  def over?
    draw? || won?
  end

  def draw?
    @board.full? && !won?
  end

  def won?
    @judge.winning_combination?(@current_player)
  end
end
