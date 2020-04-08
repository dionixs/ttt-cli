# frozen_string_literal: true

class Engine
  attr_accessor :difficulty

  @@game_mode = :multiplayer

  @@draws = 0
  @@wins = 0
  @@losses = 0

  include Emoji

  DIFFICULTY_LEVELS = {
      easy: RandomAI,
      medium: MediumAI,
      hard: HardAI
  }.freeze

  def self.set_game_mode
    if Engine.is_multiplayer?
      Engine.reset_counters
      @@game_mode = :multiplayer
    else
      Engine.reset_counters
      @@game_mode = :singleplayer
    end
  end

  def self.is_multiplayer?
    Engine.game_mode == :multiplayer
  end

  def self.set_difficulty
    if @@game_mode != :singleplayer
      Engine.difficulty_level
    else
      RandomAI
    end
  end

  def self.game_mode
    mode = CommandLine::Display.game_mode
    mode.to_sym
  end

  def self.difficulty_level
    level = CommandLine::Display.difficulty
    DIFFICULTY_LEVELS[level.to_sym]
  end

  def self.reset_counters
    if @@game_mode == :singleplayer
      @@draws, @@losses, @@wins = 0, 0, 0
    else @@game_mode == :multiplayer
      @@draws, @@losses, @@wins = 0, 0, 0
    end
  end

  def game_mode
    @@game_mode
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
