# frozen_string_literal: true

require 'ttt-cli'

include Emoji

describe Judge do
  before { @game = Game.new }

  it 'combo check' do
    board = [X, O, DASH, DASH, X, DASH, DASH, O, X]
    @game.board.cells = board
    @game.judge.board = board

    player = @game.current_player
    expect(@game.judge.is_combo?(player)).to eq true
  end
end
