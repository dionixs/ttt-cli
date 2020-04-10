# frozen_string_literal: true

require 'ttt-cli'

include Emoji

describe Board do
  before { @game = Game.new }

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

  it 'should empty cells' do
    @game.board.fill_cell(0, X)
    expect(@game.board.empty_cells.size).to eq 8
  end

  it 'should even cells' do
    expect(@game.board.even_cells.size).to eq 5
  end

  it 'should emty cell' do
    @game.board.fill_cell(0, X)
    expect(@game.board.reset_cell(0)).to eq DASH
  end
end
