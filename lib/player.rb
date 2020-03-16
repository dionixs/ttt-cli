# frozen_string_literal: true

# Класс Player (abstract class)
class Player
  attr_reader :token, :name

  def initialize(token, name = nil)
    @token = token
    @name = name
  end

  def position; end

  def move(player = self, board); end
end
