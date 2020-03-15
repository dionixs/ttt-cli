require 'rainbow'

# Класс Board - игровое поле.
#
# По умолчанию имеет размер 3х3.
class Board
  attr_accessor :cells

  def initialize
    @cells = Array.new(9, '-')
  end

  # метод для заполнения клетки
  def fill_cell(index, token)
    @cells[index] = token
  end

  # метод для проверки клетки на занятость
  def cell_taken?(index)
    @cells[index] != '-'
  end

  def full?
    @cells.all? do |character|
      if character == 'X' || character == 'O'
        true
      else
        false
      end
    end
  end

  def to_s
    Rainbow("
      +---+---+---+
      | #{@cells[0]} | #{@cells[1]} | #{@cells[2]} |
      +---+---+---+
      | #{@cells[3]} | #{@cells[4]} | #{@cells[5]} |
      +---+---+---+
      | #{@cells[6]} | #{@cells[7]} | #{@cells[8]} |
      +---+---+---+
    ").lawngreen
  end
end

