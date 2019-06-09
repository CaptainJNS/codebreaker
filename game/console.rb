class Console
  class << self
    include Validation
    include DataUtils

    def run
      loop do
        puts I18n.t(:menu)
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
      puts I18n.t(:rules)
    end

    def stats
      puts 'THIS IS STATS'
    end

    def close
      puts I18n.t(:goodbye)
      exit
    end

    def wrong_input(from)
      wrong_input_hash = {
        choose_difficulty: I18n.t(:wrong_difficulty),
        game_process: I18n.t(:wrong_process),
        choose_name: I18n.t(:wrong_name),
        run: I18n.t(:wrong_run)
      }
      puts wrong_input_hash[from]
    end

    def choose_difficulty
      loop do
        puts I18n.t(:choose_difficulty)
        case gets.chomp
        when 'exit' then break close
        when 'easy' then break I18n.t(:easy)
        when 'medium' then break I18n.t(:medium)
        when 'hard' then break I18n.t(:hard)
        when 'HELL' then break I18n.t(:hell)
        else wrong_input(__method__)
        end
      end
    end

    def choose_name
      loop do
        puts I18n.t(:choose_name)
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
        puts I18n.t(:game_process, attempts: @game.attempts, hints: @game.hints)
        input = gets.chomp
        case input
        when 'exit' then break close
        when 'hint' then next puts(@game.use_hint)
        else next wrong_input(__method__) unless guess_is_valid?(input)
        end

        puts @game.check(input)
        break if @game.attempts.zero? || @game.win
      end
      puts I18n.t(:game_over)
    end

    def game_summary
      puts I18n.t(:secret, secret: @game.secret)
      if @game.win
        puts I18n.t(:win)
        print I18n.t(:save)
        save_results if gets.chomp == 'save'
      else
        puts I18n.t(:lose)
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
