require_relative '../lib/emoji'
require_relative '../lib/display'
require_relative '../lib/board'
require_relative '../lib/ai'
require_relative '../lib/strategies/random_ai'
require_relative '../lib/strategies/medium_ai'
require_relative '../lib/strategies/hard_ai'
require_relative '../lib/player'
require_relative '../lib/players/computer'
require_relative '../lib/players/human'
require_relative '../lib/judge'
require_relative '../lib/engine'
require_relative '../lib/game'

include Emoji

describe Judge do
  before { @game = Game.new}

  it 'combo check' do
    board = [X, O, DASH, DASH, X, DASH, DASH, O, X]
    @game.board.cells = board
    @game.judge.board = board

    player = @game.current_player
    expect(@game.judge.is_combo?(player)).to eq true
  end
end