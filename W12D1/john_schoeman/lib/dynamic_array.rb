require_relative "static_array"

class DynamicArray
  attr_reader :length, :capacity
  attr_accessor :static_array

  def initialize
    @static_array = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    raise "index out of bounds" unless check_index(index)
    self.static_array[index % self.length]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" unless check_index(index)
    self.static_array[index % self.length] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if self.length == 0
    self.length -= 1
    return @static_array[self.length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if self.length == self.capacity
      self.resize!
    end
    self.length += 1
    self[length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    result = self[0]
    (1...self.length).each do |i|
      self[i - 1] = self[i]
    end
    self.length -= 1
    result
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if self.length == self.capacity
      self.resize!
    end
    self.length += 1
    (length - 2).downto(0) do |i|
      self[i + 1] = self[i]
    end
    self[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    (0...self.length).include?(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_static_array = StaticArray.new(self.capacity * 2)
    self.capacity *= 2
    (0...self.length).each do |i|
      new_static_array[i] = self[i]
    end
    self.static_array = new_static_array
  end
end
