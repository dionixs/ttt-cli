# frozen_string_literal: true

require 'yaml'

class Engine
  attr_accessor :difficulty

  include Emoji

  DIFFICULTY_LEVELS = {
      easy: RandomAI,
      medium: MediumAI,
      hard: HardAI
  }.freeze

  def self.game_mode
    mode = CommandLine::Display.game_mode
    mode.to_sym
  end

  def self.difficulty_level
    level = CommandLine::Display.difficulty
    DIFFICULTY_LEVELS[level.to_sym]
  end
end
