class Game
  class << self
    include Validation
    include GameLogic
    include DataUtils

    def start
      game_registration
      @win = false
      @secret = make_number
      game_process
      game_summary
    end

    private

    def game_process
      unused_hints = @secret.chars
      while @attempts.positive?
        puts "Secret code is #{@secret}"
        puts "#{@attempts} attempts and #{@hints} hints left. Guess a secret code"
        prompt = gets.chomp
        case prompt
        when 'exit' then close
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
        puts 'Sorry, you lose. Maybe another time.'
      end
    end

    def save_results
      summary = {
        name: @name,
        difficulty: @difficulty,
        att_total: @total_attempts,
        att_used: @total_attempts - @attempts,
        hints_total: @total_hints,
        hints_used: @total_hints - @hints
      }
      save(summary)
    end

    def choose_difficulty(text = '')
      puts text
      puts 'Choose difficulty: easy, medium, hard, HELL'
      case gets.chomp
      when 'exit' then close
      when 'easy' then @difficulty = 'Easy'
      when 'medium' then @difficulty = 'Medium'
      when 'hard' then @difficulty = 'Hard'
      when 'HELL' then @difficulty = 'HELL'
      else choose_difficulty('You have passed unexpected command. Please choose one from listed commands')
      end
    end

    def difficulty_set(difficulty)
      difficulty_hash = {
        'Easy' => 3,
        'Medium' => 2,
        'Hard' => 1,
        'HELL' => 0
      }
      @total_attempts = @attempts = difficulty_hash[difficulty] * 5
      @total_hints = @hints = difficulty_hash[difficulty]
      @total_attempts = @attempts += 3 if difficulty == 'HELL'
      # case difficulty
      # when 'Easy'
      #   @total_attempts = @attempts = 15
      #   @total_hints = @hints = 3
      # when 'Medium'
      #   @total_attempts = @attempts = 10
      #   @total_hints = @hints = 2
      # when 'Hard'
      #   @total_attempts = @attempts = 5
      #   @total_hints = @hints = 1
      # when 'HELL'
      #   @total_attempts = @attempts = 3
      #   @total_hints = @hints = 0
      # end
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
      close if name == 'exit'
      name_is_valid?(name) ? name : prompt_name('Your name is not valid.')
    end

    def close
      puts 'Goodbye!'
      exit
    end
  end
end
