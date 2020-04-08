# frozen_string_literal: true

require 'yaml'

class Engine
  attr_accessor :difficulty

  @@game_mode = :multiplayer

  include Emoji

  DIFFICULTY_LEVELS = {
      easy: RandomAI,
      medium: MediumAI,
      hard: HardAI
  }.freeze

  def self.set_game_mode
    if Engine.is_multiplayer?
      @@game_mode = :multiplayer
    else
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

  def game_mode
    @@game_mode
  end
end
