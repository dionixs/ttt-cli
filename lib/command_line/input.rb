require 'rainbow'

module CommandLine
  class Input
    # Метод для выбора X или O
    #
    # Возвращает массив, в котором:
    # -- буква игрока - первый элемент,
    # -- буква компьютера - второй.
    def self.players_choice
      token = nil

      while token != 'X' && token != 'O'
        Display.choose_token
        token = get_input.upcase
      end

      token == 'X' ? ['X', 'O'] : ['O', 'X']
    end

    def self.get_input
      print Rainbow(">> ").lawngreen
      STDIN.gets.strip
    end

    def self.clear
      system "clear" or system "cls"
    end
  end
end