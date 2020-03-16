# frozen_string_literal: true

require 'rainbow'

module CommandLine
  class Display
    def self.welcome_banner
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
      puts Rainbow("You Win!\n").deepskyblue
    end

    def self.draw
      puts Rainbow("Draw!\n").yellow
    end

    def self.loser
      puts Rainbow("You Lose!\n").red
    end
  end
end
