# frozen_string_literal: true

require 'rainbow'

# Класс Board - игровое поле.
#
# По умолчанию имеет размер 3х3.
class Board
  attr_accessor :cells

  include Emoji

  def initialize(game)
    @cells = Array.new(9, DASH)
    @game = game
  end

  # метод для заполнения клетки
  def fill_cell(index, token)
    @cells[index] = token
  end

  # метод для проверки клетки на занятость
  def cell_taken?(index)
    @cells[index] == X || @cells[index] == O
  end

  # метод для проверки всех клеток на занятость
  def full?
    @cells.all? do |char|
      if char == X || char == O
        true
      else
        false
      end
    end
  end

  # метод возвращает массив индексов пустых клеток доски
  def empty_cells
    @cells.filter_map.with_index do |cell, index|
      index if cell != X && cell != O
    end
  end

  # метод возвращает массив четных индексов клеток доски
  def even_cells
    empty_cells.filter { |cell| cell.even? }
  end

  # метод для очистки клетки
  def reset_cell(index)
    @cells[index] = DASH
  end

  def to_s
    Rainbow("
    +---------------+
    |  Tic-Tac-Toe  |
    +---------------+

        |      |
    #{@cells[0]}  |  #{@cells[1]}  |  #{@cells[2]}
  ______|______|______
        |      |
    #{@cells[3]}  |  #{@cells[4]}  |  #{@cells[5]}
  ______|______|______
        |      |
    #{@cells[6]}  |  #{@cells[7]}  |  #{@cells[8]}
        |      |

  Human   Tie   Computer
    #{@game.wins}      #{@game.draws}       #{@game.losses}
    ").lawngreen
  end
end
