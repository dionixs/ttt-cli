# frozen_string_literal: true

# Класс Player (abstract class)
class Player
  attr_reader :board, :token, :name, :enemy
  include Emoji

  def initialize(params)
    @name = params[:name]
    @token = params[:token]
  end

  def position; end

  def move(board); end
end
