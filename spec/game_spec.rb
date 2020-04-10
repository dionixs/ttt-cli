# frozen_string_literal: true

require 'ttt-cli'

include Emoji

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

  it 'easy level' do
    Game.set_game_mode(:singleplayer)
    game = Game.new(RandomAI)
    expect(game.difficulty).to eq RandomAI
  end

  it 'medium level' do
    Game.set_game_mode(:singleplayer)
    game = Game.new(MediumAI)
    expect(game.difficulty).to eq MediumAI
  end

  it 'hard level' do
    Game.set_game_mode(:singleplayer)
    game = Game.new(HardAI)
    expect(game.difficulty).to eq HardAI
  end

  it 'human goes first' do
    Game.set_game_mode(:singleplayer)
    game = Game.new(HardAI)
    game.update_players!
    game.set_players_tokens('X')
    game.who_goes_first
    expect(game.current_player.token).to eq game.first_player.token
  end

  it 'computer goes first' do
    Game.set_game_mode(:singleplayer)
    game = Game.new(HardAI)
    game.update_players!
    game.set_players_tokens('O')
    game.who_goes_first
    expect(game.current_player.token).to eq game.second_player.token
  end

  it 'switch players' do
    Game.set_game_mode(:singleplayer)

    game = Game.new(RandomAI)
    first_player = Players::Computer.new(token: X, game: game)
    game.first_player = first_player
    game.current_player = first_player

    # проверка переключения игроков
    2.times do
      game.current_player.make_move(game.board)
      game.switch_player
    end

    expect(game.current_player.token).to eq X
  end

  it 'check draw' do
    Game.set_game_mode(:singleplayer)
    game = Game.new(RandomAI)

    cell = [X, O, X, X, X, O, O, X, O]
    game.board.cells = cell

    expect(game.draw?).to eq true
  end

  it 'check win' do
    Game.set_game_mode(:singleplayer)
    game = Game.new(RandomAI)

    cell = [X, O, O, X, O, O, X, X, X]
    game.board.cells = cell
    game.judge.board = cell

    expect(game.won?).to eq true
  end

  it 'check counter win' do
    Game.set_game_mode(:singleplayer)
    game = Game.new(RandomAI)

    cell = [X, O, O, X, O, O, X, X, X]
    game.board.cells = cell
    game.judge.board = cell

    10.times { game.increase_counter }
    expect(game.wins).to eq 10
  end

  it 'check counter draws' do
    Game.set_game_mode(:singleplayer)
    game = Game.new(RandomAI)

    cell = [X, O, X, X, X, O, O, X, O]
    game.board.cells = cell

    5.times { game.increase_counter }
    expect(game.draws).to eq 5
  end

  it 'check counter losses' do
    Game.set_game_mode(:singleplayer)
    game = Game.new(RandomAI)

    cell = [X, DASH, X, DASH, X, DASH, O, O, O]
    game.board.cells = cell
    game.judge.board = cell

    8.times { game.increase_counter }
    expect(game.losses).to eq 8
  end
end
