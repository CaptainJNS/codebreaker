class GameConsole
  include Validation
  include DataUtils

  def initialize(name, difficulty)
    @game = Game.new(name: name, difficulty: difficulty)
  end

  def start
    loop do
      break if @game.attempts.zero? || @game.win
      # puts "Secret code is #{@game.secret}"
      puts I18n.t(:game_process, attempts: @game.attempts, hints: @game.hints)
      input = gets.chomp
      case input
      when 'exit' then break close
      when 'hint' then next puts(@game.use_hint)
      else next puts(I18n.t(:wrong_process)) unless guess_is_valid?(input)
      end

      puts @game.check(input)
    end
    puts I18n.t(:game_over)
    game_summary
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

  def close
    puts I18n.t(:goodbye)
    exit
  end
end
