class Console
  class << self
    def run
      loop do
        puts 'Choose one of next scenarios: "start", "rules", "stats", "exit"'
        case gets.chomp
        when 'start' then start
        when 'rules' then rules
        when 'stats' then stats
        when 'exit' then close
        else puts('You have passed unexpected command. Please choose one from listed commands')
        end
      end
    end

    def start
      Game.start
    end

    def rules
      puts 'THIS IS RULES'
    end

    def stats; end

    def close
      puts 'Goodbye!'
      exit
    end
  end
end
