module Validation
  def name_is_valid?(name)
    name.is_a?(String) && name.length.between?(3, 20)
  end

  def guess_is_valid?(guess)
    guess.to_i.between?(1111, 6666)
  end
end
