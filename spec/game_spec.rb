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

describe Game do

  it 'singleplayer game mode' do
    Game.set_game_mode(:singleplayer)
    game = Game.new
    expect(game.game_mode).to eq :singleplayer
  end

  it 'hotseat game mode' do
    Game.set_game_mode(:hotseat)
    game = Game.new
    expect(game.game_mode).to eq :hotseat
  end

  it 'players for singleplayer mode' do
    Game.set_game_mode(:singleplayer)
    game = Game.new
    game.update_players!

    first_player = game.first_player.class
    second_player = game.second_player.class

    expect(first_player).to eq Players::Human
    expect(second_player).to eq Players::Computer
  end

  it 'players for hotseat mode' do
    Game.set_game_mode(:hotseat)
    game = Game.new
    game.update_players!

    first_player = game.first_player.class
    second_player = game.second_player.class

    expect(first_player).to eq Players::Human
    expect(second_player).to eq Players::Human
  end
end


