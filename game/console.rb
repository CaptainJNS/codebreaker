class Console
  class << self
    include Validation
    include DataUtils

    def run
      loop do
        puts 'Choose one of next scenarios: "start", "rules", "stats", "exit"'
        case gets.chomp
        when 'start' then break start
        when 'rules' then rules
        when 'stats' then stats
        when 'exit' then break close
        else wrong_input(__method__)
        end
      end
    end

    def start
      game_registration
      game_process
      game_summary
    end

    def rules
      puts 'THIS IS RULES'
    end

    def stats
      puts 'THIS IS STATS'
    end

    def close
      puts 'Goodbye!'
      exit
    end

    def wrong_input(from)
      wrong_input_hash = {
        choose_difficulty: 'There is no such difficulty. Please choose one from listed',
        game_process: 'There is no such command or your number is invalid. You can try use hint or exit',
        choose_name: 'Choosen name is invalid. Please choose another one',
        run: 'You have passed unexpected command. Please choose one from listed commands'
      }
      puts wrong_input_hash[from]
    end

    def choose_difficulty
      loop do
        puts 'Choose difficulty: easy, medium, hard, HELL'
        case gets.chomp
        when 'exit' then break close
        when 'easy' then break 'Easy'
        when 'medium' then break 'Medium'
        when 'hard' then break 'Hard'
        when 'HELL' then break 'HELL'
        else wrong_input(__method__)
        end
      end
    end

    def choose_name
      loop do
        puts 'Choose your name'
        name = gets.chomp
        break close if name == 'exit'
        break name if name_is_valid?(name)

        wrong_input(__method__)
      end
    end

    def game_registration
      @game = Game.new(name: choose_name, difficulty: choose_difficulty)
    end

    def game_process
      loop do
        # puts "Secret code is #{@game.secret}"
        puts "#{@game.attempts} attempts and #{@game.hints} hints left. Guess a secret code"
        input = gets.chomp
        case input
        when 'exit' then break close
        when 'hint' then next puts(@game.use_hint)
        else next wrong_input(__method__) unless guess_is_valid?(input)
        end

        puts @game.check(input)
        break if @game.attempts.zero? || @game.win
      end
      puts 'Game Over'
    end

    def game_summary
      puts "The secret code was #{@game.secret}"
      if @game.win
        puts 'Congratulations! You win!'
        print 'Print "save" if you want to save your result: '
        save_results if gets.chomp == 'save'
      else
        puts 'Sorry, you lose. Maybe another time.'
      end
    end

    def save_results
      summary = {
        name: @game.name,
        difficulty: @game.difficulty,
        att_total: @game.att_total,
        att_used: @game.att_total - @game.attempts,
        hints_total: @game.hints_total,
        hints_used: @game.hints_total - @game.hints
      }
      save(summary)
    end
  end
end
