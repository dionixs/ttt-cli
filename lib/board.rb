# frozen_string_literal: true

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
    @cells[index] == 'X' || @cells[index] == 'O'
  end

  # метод для проверки всех клеток на занятость
  def full?
    @cells.all? do |char|
      if char == 'X' || char == 'O'
        true
      else
        false
      end
    end
  end

  # метод возвращает массив индексов пустых клеток доски
  def empty_cells
    @cells.filter_map.with_index do |cell, index|
      index if cell != 'X' && cell != 'O'
    end
  end

  def reset
    @cells.map { |item| item = "-"}
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


