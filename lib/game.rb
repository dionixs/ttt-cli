class Game
  attr_accessor :board, :players_tokens, :first_player, :second_player, :judge

  def self.start
    CommandLine::Display.welcome_banner
    new(CommandLine::Input.players_choice)
  end

  def initialize(players_tokens)
    @board = Board.new
    @players_tokens = players_tokens
    @human = Players::Human.new(@players_tokens[0])
    @computer = Players::Computer.new(@players_tokens[1])
    @first_player = @human
    @second_player = @computer
    @judge = Judge.new
  end

  # Метод для выбора игрока, который будет ходить первым.
  #
  # По умолчанию первым ходит игрок.
  #
  # Если игрок выбрал "O", данный метод изменит порядок игроков.
  def who_goes_first
    if @players_tokens[0] != 'X'
      first_player, second_player = @computer, @human
    end
  end

  # todo
  def make_move(player)
    move = player.move
    if !@board.cell_taken?(move)
      @board.fill_cell(move, player.token)
    else
      CommandLine::Display.invalid_choice # todo
      make_move(player)
    end
  end
end
