# frozen_string_literal: true

require 'rainbow'

module CommandLine
  class Display
    def initialize # todo
      @board = nil
    end

    def self.welcome_banner
      system('clear') || system('cls')
      puts Rainbow("Welcome to Tic Tac Toe!\n").lawngreen
    end

    def self.difficulty
      puts Rainbow("Please enter a difficulty level:\n1 - easy\n2 - medium\n3 - hard\n").lawngreen
    end

    def self.choose_token
      system('clear') || system('cls')
      puts Rainbow("Do you want to be X or O?\n").lawngreen
    end

    def self.choose_cell
      puts Rainbow("What is your move? (1-9)\n").lawngreen
    end

    def self.invalid_choice
      puts Rainbow("Oops! Sorry, that wasn't a valid response. Try again! \n").red
    end

    def self.winner
      CommandLine::Display.print_board(@board)
      puts Rainbow("\tYou Win!\n").deepskyblue
    end

    def self.draw
      CommandLine::Display.print_board(@board)
      puts Rainbow("\tDraw!\n").yellow
    end

    def self.play_again
      puts Rainbow("Would you to play again? (y/n)\n").lawngreen
    end

    def self.loser
      CommandLine::Display.print_board(@board)
      puts Rainbow("\tYou Lose!\n").red
    end

    def self.print_board(board)
      @board = board
      system('clear') || system('cls')
      puts @board
    end
  end
end
