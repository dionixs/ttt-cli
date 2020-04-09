# frozen_string_literal: true

class Engine
  attr_accessor :difficulty

  @@game_mode = :singleplayer

  @@draws = 0
  @@wins = 0
  @@losses = 0

  include Emoji

  DIFFICULTY_LEVELS = {
    easy: RandomAI,
    medium: MediumAI,
    hard: HardAI
  }.freeze

  def self.set_game_mode(mode)
    if Engine.is_singleplayer?(mode)
      Engine.reset_counters if @@game_mode == :hotseat
      @@game_mode = :singleplayer
    else
      Engine.reset_counters if @@game_mode == :singleplayer
      @@game_mode = :hotseat
    end
  end

  def self.is_singleplayer?(mode)
    mode == :singleplayer
  end

  def self.set_difficulty
    if @@game_mode != :hotseat
      Engine.difficulty_level
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
    @@draws = 0
    @@losses = 0
    @@wins = 0
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
