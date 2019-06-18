module GameLogic
  DIFFICULTY_HASH = {
    I18n.t(:easy) => [15, 3],
    I18n.t(:medium) => [10, 2],
    I18n.t(:hard) => [5, 1],
    I18n.t(:hell) => [3, 0]
  }.freeze

  def make_number(chars = 4, numbers = 6)
    (1..chars).map { rand(1..numbers) }.join
  end

  def check_numbers(secret, numbers)
    minuses = (secret & numbers).map { |element| [secret.count(element), numbers.count(element)].min }.sum
    result = '-' * minuses

    numbers.each.with_index do |number, index|
      result.sub!('-', '+') if number == secret[index]
    end

    result
  end

  def hint(secrets)
    secrets.shuffle!.pop
  end

  def calc_attempts_and_hints(difficulty)
    DIFFICULTY_HASH[difficulty]
  end
end
