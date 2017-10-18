class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    reduce(0) { |acc, el| acc.hash + el.hash }
  end
end

class String
  def hash
    arr = split("").map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    (keys.sort).concat(values.sort).join("").hash
  end
end
