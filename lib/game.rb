# frozen_string_literal: true

require 'yaml'

# Класс Game: Управляет игровым процессом
class Game < Engine
  attr_reader :board, :first_player, :second_player,
              :current_player, :game_mode

  @@draws = 0
  @@wins = 0
  @@losses = 0

  def self.start
    CommandLine::Display.welcome_banner
    Game.setup_game(new_game = new)
    new_game
  end

  def self.setup_game(game)
    game.update_players!
    Game.set_difficulty(game)
    game.set_players_tokens
    game.who_goes_first
    CommandLine::Display.print_board(game.board)
  end

  def self.set_difficulty(game)
    if game.game_mode != :singleplayer
      game.difficulty = Game.difficulty_level
    end
  end

  def initialize
    @board = Board.new(self)
    @difficulty = HardAI
    @game_mode = :multiplayer
    @first_player = Players::Human.new(token: X)
    @second_player = Players::Computer.new(token: O, game: self)
    @current_player = @first_player
    @judge = Judge.new(self)
  end

  def start_new_game?
    CommandLine::Display.play_again
  end

  def update_players!
    if is_multiplayer?
      @game_mode = :multiplayer
      multiplayer_mode
    else
      @game_mode = :singleplayer
      singleplayer_mode
    end
  end

  def is_multiplayer?
    Game.game_mode == :multiplayer
  end

  def multiplayer_mode
    @second_player = Players::Computer.new(token: O, game: self)
  end

  def singleplayer_mode
    @first_player = Players::Human.new(token: X, name: "Player 1")
    @second_player = Players::Human.new(token: O, name: "Player 2")
    @current_player = @first_player
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
  def switch_player
    case @current_player
    when @first_player
      @current_player = @second_player
    else
      @current_player = @first_player
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
