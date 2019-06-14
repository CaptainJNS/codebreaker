class WelcomeConsole
  class << self
    include Validation
    include DataUtils
    DIFFICULTY_HASH = {
      1 => I18n.t(:easy),
      2 => I18n.t(:medium),
      3 => I18n.t(:hard),
      4 => I18n.t(:hell)
    }.freeze

    def welcome
      puts(I18n.t(:greeting))
      run
    end

    def run
      loop do
        puts I18n.t(:menu)
        case gets.chomp
        when 'start' then break registration
        when 'rules' then rules
        when 'stats' then puts stats
        when 'exit' then break close
        else wrong_input(__method__)
        end
      end
    end

    def registration
      game_console = GameConsole.new(choose_name, choose_difficulty)
      game_console.start
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

    def rules
      puts I18n.t(:rules)
    end

    def stats
      table = load.sort_by{|row| [-row.difficulty, row.att_used] }
      table.map {|row| row.difficulty = DIFFICULTY_HASH[row.difficulty]}
      puts table
    end

    def wrong_input(from)
      wrong_input_hash = {
        choose_difficulty: I18n.t(:wrong_difficulty),
        choose_name: I18n.t(:wrong_name),
        run: I18n.t(:wrong_run)
      }
      puts wrong_input_hash[from]
    end

    def close
      puts I18n.t(:goodbye)
      exit
    end
  end
end
