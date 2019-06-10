module GameLogic
  def make_number(chars = 4, numbers = 6)
    (1..chars).map { rand(1..numbers) }.join
  end

  def check_numbers(secret, numbers)
    result = []
    secrets = String.new(secret)

    numbers.each_char.with_index do |number, index|
      if number == secrets[index]
        result.unshift(secrets[index] = '+')
      elsif secrets.include?(number)
        secrets.sub!(number, '-')
        result.push('-')
      end
    end

    result.join
  end

  def hint(secrets)
    secrets.shuffle!.pop
  end
end
