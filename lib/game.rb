# frozen_string_literal: true

# Класс Game: Управляет игровым процессом
class Game
  include Emoji

  attr_accessor :difficulty
  attr_reader :board, :human, :computer, :current_player

  DIFFICULTY_LEVELS = {
    easy: RandomAI,
    medium: MediumAI,
    hard: HardAI
  }.freeze

  @@draws = 0
  @@wins = 0
  @@losses = 0

  def self.start
    CommandLine::Display.welcome_banner
    new_game = new
    new_game.set_players_tokens
    new_game.who_goes_first
    CommandLine::Display.print_board(new_game.board)
    new_game
  end

  def initialize
    @board = Board.new(self)
    @difficulty = Game.get_difficulty_level
    @human = Players::Human.new(token: X)
    @computer = Players::Computer.new(token: O, game: self)
    @current_player = @human
    @judge = Judge.new(self)
  end

  def start_new_game?
    CommandLine::Display.play_again
  end

  def self.get_difficulty_level
    level = CommandLine::Display.difficulty
    DIFFICULTY_LEVELS[level.to_sym]
  end

  # Метод который устанавливает символы игрокам
  # По умолчанию игрок - X, компьютер - O
  def set_players_tokens
    if get_user_token != 'X'
      @human.token = O
      @computer.token = X
    end
  end

  # Метод для получения символа игрока
  def get_user_token
    CommandLine::Display.choose_token
  end

  # Метод для выбора игрока, который будет ходить первым.
  # По умолчанию первым ходит игрок.
  def who_goes_first
    case @human.token
    when O
      @current_player = @computer
    end
  end

  # Метод для переключения на следующего игрока
  def switch_player
    case @current_player
    when @human
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

  def won?(player = @current_player)
    @judge.is_combo?(player)
  end

  # Метод для объявления победителя
  def over_message # todo
    if draw?
      @@draws += 1
      CommandLine::Display.print_board(board)
      CommandLine::Display.draw
    elsif won?(@human)
      @@wins += 1
      CommandLine::Display.print_board(board)
      CommandLine::Display.winner
    elsif won?(@computer)
      @@losses += 1
      CommandLine::Display.print_board(board)
      CommandLine::Display.loser
    end
  end

  def wins
    @@wins
  end

  def draws
    @@draws
  end

  def losses
    @@losses
  end
end
