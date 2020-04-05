require 'rainbow'
require 'tty-prompt'

module CommandLine
  class Display
    def self.prompt
      TTY::Prompt.new(interrupt: :exit)
    end

    def self.welcome_banner
      clear
      puts Rainbow("Welcome to Tic Tac Toe!\n").lawngreen
    end

    def self.clear
      system('clear') || system('cls')
    end

    def self.difficulty
      levels = %w[easy medium hard]
      prompt.select(
          'Select a difficulty level:',
          levels, symbols: {marker: '>'}
      )
    end

    def self.choose_token(tokens = %w[X O])
      clear
      prompt.select(
          'Do you want to be X or O?',
          tokens, symbols: {marker: '>'}
      )
    end

    def self.choose_cell
      prompt.ask("What is your move? (1-9):") do |q|
        q.in '1-9'
        q.messages[:range?] = "Oops! Sorry, that wasn't a valid response. Try again!"
      end
    end

    def self.winner
      puts Rainbow("\tYou Win!\n").deepskyblue
    end

    def self.draw
      puts Rainbow("\tDraw!\n").yellow
    end

    def self.play_again
      prompt.yes?('Would you to play again?')
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