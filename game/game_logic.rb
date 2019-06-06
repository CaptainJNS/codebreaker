module GameLogic
  def make_number(chars = 4, numbers = 6)
    left_edge = ('1' * chars).to_i
    right_edge = (numbers.to_s * chars).to_i
    rand(left_edge..right_edge)
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
