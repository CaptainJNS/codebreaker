module Validation
  def name_is_valid?(name)
    name.is_a?(String) && name.length >= 3 && name.length <= 20
  end

  def guess_is_valid?(guess)
    guess.is_a?(Integer) && guess >= 1111 && guess <= 6666
  end
end
