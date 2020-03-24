# frozen_string_literal: true

# Класс Player (abstract class)
class Player
  attr_reader :board, :token, :name, :enemy

  def initialize(params)
    @token = params[:token]
    @enemy = params[:enemy]
  end

  def position; end

  def move(board); end
end
