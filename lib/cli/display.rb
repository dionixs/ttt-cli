# frozen_string_literal: true

require 'rainbow'

module CommandLine
  class Display
    def self.welcome_banner
      system('clear') || system('cls')
      puts Rainbow("Welcome to Tic Tac Toe!\n").lawngreen
    end

    def self.choose_token
      puts Rainbow("Do you want to be X or O?\n").lawngreen
    end

    def self.choose_cell
      puts Rainbow("What is your move? (1-9)\n").lawngreen
    end

    def self.invalid_choice
      puts Rainbow("Oops! Sorry, that wasn't a valid response. Try again! \n").red
    end

    def self.winner
      puts Rainbow("\tYou Win!\n").deepskyblue
    end

    def self.draw
      puts Rainbow("\tDraw!\n").yellow
    end

    def self.play_again
      puts Rainbow("Would you to play again? (y/n)\n").lawngreen
    end

    def self.loser
      puts Rainbow("\tYou Lose!\n").red
    end

    def self.print_board(board)
      system('clear') || system('cls')
      puts board
    end
  end
end
