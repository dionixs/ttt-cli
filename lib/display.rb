# frozen_string_literal: true

require 'rainbow'
require 'tty-prompt'
require 'tty-table'

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

    def self.game_mode
      modes = %w[singleplayer hotseat]
      prompt.select(
          'Choose game mode:',
          modes, symbols: {marker: '>'}
      )
    end

    def self.choose_token(tokens = %w[X O])
      prompt.select(
          'Do you want to be X or O?',
          tokens, symbols: {marker: '>'}
      )
    end

    def self.choose_cell(choice = nil)
      moves = Array(1..9).map { |item| item.to_s}
      while !moves.include?(choice) && choice != 'exit'
        print Rainbow("What is your move? (1-9): ").lawngreen
        choice = STDIN.gets.strip
      end
      exit if choice == 'exit'
      choice.to_i - 1
    end

    def self.winner(game)
      if game.game_mode == :singleplayer
        puts Rainbow("\tYou Win!\n").deepskyblue
      else
        puts Rainbow("#{game.current_player.name} has won the game!\n").deepskyblue
      end
    end

    def self.draw
      puts Rainbow("\tDraw!\n").yellow
    end

    def self.play_again
      prompt.yes?('Would you to play again?')
    end

    def self.loser(game)
      if game.game_mode == :singleplayer
        puts Rainbow("\tYou Lose!\n").red
      else
        winner(game)
      end
    end

    def self.logo
      "
    ┌───────────────┐
    │  Tic-Tac-Toe  │
    └───────────────┘"
    end

    def self.scoreboard(game)
      table = TTY::Table.new [game.first_player.name, '  Tie  ', game.second_player.name],
                             [[game.wins, game.draws, game.losses]]
      scoreboard = table.render :unicode, alignment: [:center]
      puts Rainbow(scoreboard).lawngreen
      puts
    end

    def self.print_board(board)
      clear
      puts Rainbow(logo).lawngreen
      puts board
      scoreboard(board.game)
    end
  end
end
