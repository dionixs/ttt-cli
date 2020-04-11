# frozen_string_literal: true

# Класс Game: Управляет игровым процессом
class Game < Engine
  attr_accessor :first_player, :second_player,
                :current_player, :judge
  attr_reader :board

  def self.start
    CommandLine::Display.welcome_banner
    Game.set_game_mode(Game.game_mode)
    new_game = new(Game.set_difficulty)
    Game.setup_game(new_game)
  end

  def self.setup_game(game)
    game.update_players!
    game.set_players_tokens(game.get_user_token)
    game.who_goes_first
    CommandLine::Display.print_board(game.board)
    game
  end

  def initialize(difficulty = MediumAI)
    @board = Board.new(self)
    @difficulty = difficulty
    @first_player = Players::Human.new(token: X)
    @second_player = Players::Computer.new(token: O, game: self)
    @current_player = @first_player
    @judge = Judge.new(self)
  end

  def start_new_game?
    CommandLine::Display.play_again
  end

  def update_players!
    if @@game_mode == :singleplayer
      singleplayer_mode
    elsif @@game_mode == :hotseat
      hotseat_mode
    else
      observer_mode
    end
  end

  def singleplayer_mode
    @second_player = Players::Computer.new(token: O, game: self)
  end

  def hotseat_mode
    @first_player = Players::Human.new(token: X, name: 'Player 1')
    @second_player = Players::Human.new(token: O, name: 'Player 2')
    @current_player = @first_player
  end

  def observer_mode
    @first_player = Players::Computer.new(token: X, name: 'Connor', game: self)
    @second_player = Players::Computer.new(token: O, name: 'William', game: self)
    @current_player = @first_player
  end

  def get_user_token
    if @@game_mode == :singleplayer
      CommandLine::Display.user_token
    end
  end

  # Метод который устанавливает символы игрокам
  # По умолчанию игрок - X, компьютер - O
  def set_players_tokens(token)
    if @@game_mode == :singleplayer
      if token != 'X'
        @first_player.token = O
        @second_player.token = X
      end
    end
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

  def over_message
    increase_counter
    CommandLine::Display.print_board(@board)
    print_winner
  end

  # Метод для объявления победителя
  def print_winner
    if draw?
      CommandLine::Display.draw
    elsif won?(@first_player)
      CommandLine::Display.winner(self)
    elsif won?(@second_player)
      CommandLine::Display.loser(self)
    end
  end

  def increase_counter
    if draw?
      @@draws += 1
    elsif won?(@first_player)
      @@wins += 1
    elsif won?(@second_player)
      @@losses += 1
    end
  end
end
