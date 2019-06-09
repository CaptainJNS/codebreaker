class Game
  include GameLogic

  attr_reader :att_total, :attempts, :difficulty, :hints_total, :hints, :name, :win, :secret

  def initialize(name:, difficulty:)
    @name = name
    @difficulty = difficulty
    @att_total = @attempts = calc_attempts(difficulty)
    @hints_total = @hints = calc_hints(difficulty)
    @win = false
    @secret = make_number
    @unused_hints = @secret.chars
  end

  def check(number)
    @attempts -= 1
    result = check_numbers(@secret, number)
    @win = true if result == '++++'
    result
  end

  def use_hint
    if @hints.positive?
      @hints -= 1
      hint(@unused_hints)
    else
      I18n.t(:no_hints)
    end
  end
end
