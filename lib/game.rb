# frozen_string_literal: true

# Класс Game: Управляет игровым процессом
class Game
  attr_reader :board, :human, :current_player, :judge
  include Emoji

  @@draws = 0
  @@wins = 0
  @@losses = 0

  def self.start
    CommandLine::Display.welcome_banner
    new_game = new(Game.set_players_tokens)
    new_game.who_goes_first
    CommandLine::Display.print_board(new_game.board)
    new_game
  end

  def initialize(players)
    @board = Board.new(self)
    @human = Players::Human.new(token: players[0])
    @computer = Players::Computer.new(token: players[1], game: self)
    @current_player = @human
    @judge = Judge.new(self)
  end

  def start_new_game?
    play_again == 'y' ? true : false
  end

  # Метод который устанавливает символы игрокам
  def self.set_players_tokens
    get_user_token == 'X' ? [X, O] : [O, X]
  end

  # Метод для получения символа игрока
  def self.get_user_token(token = nil)
    while token != 'X' && token != 'O'
      CommandLine::Display.choose_token
      token = CommandLine::Input.get_input.upcase
    end
    token
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

  def play_again(choice = nil)
    while choice != 'y' && choice != 'n'
      CommandLine::Display.play_again
      choice = CommandLine::Input.get_input.downcase
    end
    choice
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
