# frozen_string_literal: true

require 'ttt-cli'

include Emoji

describe AI do
  before { @game = Game.new }

  it 'should create RandomAI' do
    ai = AI.create(@game, RandomAI, @game.second_player)
    expect(ai.class).to eq RandomAI
  end

  it 'should create MediumAI' do
    ai = AI.create(@game, MediumAI, @game.second_player)
    expect(ai.class).to eq MediumAI
  end

  it 'should create HardAI' do
    ai = AI.create(@game, HardAI, @game.second_player)
    expect(ai.class).to eq HardAI
  end

  it 'move RandomAI' do
    ai = AI.create(@game, RandomAI, @game.second_player)
    move = ai.move_generate
    expect(move.between?(0, 8)).to eq true
  end

  it 'move MediumAI' do
    ai = AI.create(@game, MediumAI, @game.second_player)
    move = ai.move_generate
    expect(move.between?(0, 8)).to eq true
  end

  it 'move HardAI' do
    ai = AI.create(@game, HardAI, @game.second_player)
    move = ai.move_generate
    expect(move.between?(0, 8)).to eq true
  end
end
