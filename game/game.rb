class Game
  class << self
    include Validation
    include GameLogic

    def start
      game_registration
      @win = false
      @secret = make_number
      game_process(@secret)
      game_summary
    end

    private

    def game_process(secret)
      unused_hints = secret.chars
      while @attempts.positive?
        puts "#{@attempts} attempts and #{@hints} hints left. Guess a secret code"
        prompt = gets.chomp
        case prompt
        when 'exit' then exit!
        when 'hint' then puts(use_hint(unused_hints))
        else result = check(prompt)
        end
        puts result
        if result == '++++'
          @win = true
          break
        end
      end
      puts 'Game Over'
    end

    def check(prompt)
      if guess_is_valid?(prompt)
        @attempts -= 1
        check_numbers(@secret, prompt)
      else
        'You have passed unexpected command or incorrect number.'
      end
    end

    def game_registration
      @name = prompt_name
      difficulty_set(choose_difficulty)
    end

    def game_summary
      puts "The secret code was #{@secret}"
      if @win
        puts 'Congratulations! You win!'
        print 'Print "save" if you want to save your result: '
        save_results if gets.chomp == 'save'
      else
        'Sorry, you loose. Maybe another time.'
      end
    end

    def save_results
    end

    def choose_difficulty(text = '')
      puts text
      puts 'Choose difficulty: easy, medium, hard, HELL'
      case gets.chomp
      when 'exit' then exit!
      when 'easy' then 1
      when 'medium' then 2
      when 'hard' then 3
      when 'HELL' then 4
      else choose_difficulty('You have passed unexpected command. Please choose one from listed commands')
      end
    end

    def difficulty_set(difficulty)
      case difficulty
      when 1
        @attempts = 15
        @hints = 3
      when 2
        @attempts = 10
        @hints = 2
      when 3
        @attempts = 5
        @hints = 1
      when 4
        @attempts = 3
        @hints = 0
      end
    end

    def use_hint(unused_hints)
      if @hints.positive?
        @hints -= 1
        hint(unused_hints)
      else
        'You have no hints'
      end
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
