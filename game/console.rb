class Console
  class << self
    def run(text = '')
      puts text
      puts 'Choose one of next scenarios "start", "rules", "stats", "exit"'
      puts 'Make your choice'
      choice = gets.chomp
      case choice
      when 'start' then start
      when 'rules' then rules
      when 'stats' then stats
      when 'exit' then exit
      else run('You have passed unexpected command. Please choose one from listed commands')
      end
    end

    def start
    end

    def rules
    end

    def stats
    end

    def exit
      puts 'Goodbye!'
      exit!
    end
  end
end
