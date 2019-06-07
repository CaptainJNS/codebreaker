class Game
  class << self
    include Validation

    def run
      @win = false
      game_summary
    end

    def game_registration
    end

    def game_summary
      puts(win ? 'Congratulations!' : 'Sorry, maybe another time.')
    end

    def prompt_name(text = '')
      puts text
      puts 'Prompt your name'
      name = gets.chomp
      exit! if name == 'exit'
      name_is_valid?(name) ? name : prompt_name('Your name is not valid.')
    end
  end
end
