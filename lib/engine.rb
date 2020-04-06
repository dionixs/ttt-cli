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
    unless File.exists?(PATH_TO_CONFIG)
      abort "File #{PATH_TO_CONFIG} does not exist!"
    end
    YAML.load(File.read(PATH_TO_CONFIG))
  end

  def self.difficulty_level
    data = Game.read_from_yaml
    level = data["difficulty"].to_sym
    DIFFICULTY_LEVELS[level]
  end
end