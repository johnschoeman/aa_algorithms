include 'set'
def well_formed?(str)
  left_brackets = Set["[","{","("]
  right_brackets = Set["]","}",")"]

  h = {
    "]" => "[",
    "}" => "{",
    ")" => "("
  }

  left_brackets_stack = []
  str.each_char do |ch|
    if left_brackets.include?(ch)
      left_brackets_stack.push(ch)
    elsif right_brackets.include?(ch)
      return false unless left_brackets_stack.last == h[ch]
      left_brackets_stack.pop
    end
  end
  left_brackets_stack.empty?
end

