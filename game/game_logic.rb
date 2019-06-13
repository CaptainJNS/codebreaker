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
    result = []
    secrets = String.new(secret)
    indexes = []

    numbers.each_char.with_index do |number, index|
      if number == secrets[index]
        result.unshift(secrets[index] = '+')
        indexes.push(index)
      end
    end

    numbers.each_char.with_index do |number, index|
      if secrets.include?(number) && !indexes.include?(index)
        secrets.sub!(number, '*')
        result.push('-')
      end
    end

    result.join
  end

  def hint(secrets)
    secrets.shuffle!.pop
  end

  def calc_attempts(difficulty)
    DIFFICULTY_HASH[difficulty][0]
  end

  def calc_hints(difficulty)
    DIFFICULTY_HASH[difficulty][1]
  end
end
