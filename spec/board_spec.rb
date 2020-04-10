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

describe Board do
  before { @game = Game.new}

  it 'fill cell' do
    @game.board.fill_cell(0, X)
    expect(@game.board.cells[0]).to eq X
  end

  it 'check taken cell' do
    @game.board.fill_cell(0, X)
    expect(@game.board.cell_taken?(0)).to eq true
  end

  it 'occupied cells' do
    @game.board.cells = [X, O, X, X, X, O, O, X, O]
    expect(@game.board.full?).to eq true
  end

  it "should empty cells" do
    @game.board.fill_cell(0, X)
    expect(@game.board.empty_cells.size).to eq 8
  end

  it "should even cells" do
    expect(@game.board.even_cells.size).to eq 5
  end

  it "should emty cell" do
    @game.board.fill_cell(0, X)
    expect(@game.board.reset_cell(0)).to eq DASH
  end
end