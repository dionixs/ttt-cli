# frozen_string_literal: true

require 'yaml'

# Класс Game: Управляет игровым процессом
class Game < Engine
  attr_reader :board, :first_player, :second_player, :current_player

  @@draws = 0
  @@wins = 0
  @@losses = 0

  def self.start
    CommandLine::Display.welcome_banner
    new_game = new
    new_game.update_players!
    new_game.set_players_tokens
    new_game.who_goes_first
    CommandLine::Display.print_board(new_game.board)
    new_game
  end

  def initialize
    @board = Board.new(self)
    @difficulty = Game.difficulty_level
    @first_player = Players::Human.new(token: X)
    @second_player = Players::Computer.new(token: O, game: self)
    @current_player = @first_player
    @judge = Judge.new(self)
  end

  def start_new_game?
    CommandLine::Display.play_again
  end

  def update_players! # todo
    if Game.game_mode == :standard
      @first_player = Players::Human.new(token: X)
      @second_player = Players::Computer.new(token: O, game: self)
      @current_player = @first_player
    elsif Game.game_mode == :single_player
      @first_player = Players::Human.new(token: X)
      @second_player = Players::Human.new(token: O)
      @current_player = @first_player
    else
      @first_player = Players::Computer.new(token: X, game: self)
      @second_player = Players::Computer.new(token: O, game: self)
      @current_player = @first_player
    end
  end

  # Метод который устанавливает символы игрокам
  # По умолчанию игрок - X, компьютер - O
  def set_players_tokens
    if get_user_token != 'X'
      @first_player.token = O
      @second_player.token = X
    end
  end

  # Метод для получения символа игрока
  def get_user_token
    CommandLine::Display.choose_token
  end

  # Метод для выбора игрока, который будет ходить первым.
  # По умолчанию первым ходит игрок.
  def who_goes_first
    case @first_player.token
    when O
      @current_player = @second_player
    end
  end

  # Метод для переключения на следующего игрока
  # def switch_player
  #   case @current_player
  #   when @first_player
  #     @current_player = @second_player
  #   else
  #     @current_player = @first_player
  #   end
  # end

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
    elsif won?(@first_player)
      @@wins += 1
      CommandLine::Display.print_board(board)
      CommandLine::Display.winner
    elsif won?(@second_player)
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
