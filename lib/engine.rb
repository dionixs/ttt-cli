# frozen_string_literal: true

require 'yaml'

class Engine
  attr_accessor :difficulty

  include Emoji

  PATH_TO_CONFIG = 'config.yaml'

  DIFFICULTY_LEVELS = {
    easy: RandomAI,
    medium: MediumAI,
    hard: HardAI
  }.freeze

  def self.read_from_yaml
    unless File.exist?(PATH_TO_CONFIG)
      abort "File #{PATH_TO_CONFIG} does not exist!"
    end
    YAML.safe_load(File.read(PATH_TO_CONFIG))
  end

  def self.configuration
    Engine.read_from_yaml
  end

  def self.difficulty_level
    level = Engine.configuration['difficulty'].to_sym
    DIFFICULTY_LEVELS[level]
  end

  def self.game_mode
    Engine.configuration['game_mode'].to_sym
  end
end
