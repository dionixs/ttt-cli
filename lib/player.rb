# frozen_string_literal: true

# Класс Player (abstract class)
class Player
  attr_accessor :board, :token, :name, :enemy

  include Emoji

  def initialize(params)
    @name = params[:name]
    @token = params[:token]
  end

  def make_move(board); end

  def position; end
end
