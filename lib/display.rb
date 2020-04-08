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
        levels, symbols: { marker: '>' }
      )
    end

    def self.game_mode
      modes = %w[multiplayer singleplayer]
      prompt.select(
        'Choose game mode:',
        modes, symbols: { marker: '>' }
      )
    end

    def self.choose_token(tokens = %w[X O])
      prompt.select(
        'Do you want to be X or O?',
        tokens, symbols: { marker: '>' }
      )
    end

    def self.choose_cell
      prompt.ask('What is your move? (1-9):') do |q|
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
