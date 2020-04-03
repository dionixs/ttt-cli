# frozen_string_literal: true

require 'rainbow'

module CommandLine
  class Input
    def self.get_input
      print Rainbow('>> ').lawngreen
      STDIN.gets.strip
    end
  end
end
