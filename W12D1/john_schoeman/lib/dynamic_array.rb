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
    check_index(index)
    # self.static_array[index % self.length]
    static_array[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    # self.static_array[index % self.length] = value
    static_array[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if self.length == 0
    self.length -= 1
    return @static_array[self.length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible resize.
  def push(val)
    self.resize! if self.length == self.capacity
    self.length += 1
    self[length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    result = self[0]
    (1...self.length).each { |i| self[i - 1] = self[i] }
    self.length -= 1
    result
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    self.resize! if self.length == self.capacity
    self.length += 1
    (length - 2).downto(0) { |i| self[i + 1] = self[i] }
    self[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    # (0...self.length).include?(index)
    raise "index out of bounds" unless (index >= 0) && (index < length)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    self.capacity *= 2
    new_static_array = StaticArray.new(self.capacity)
    (0...self.length).each { |i| new_static_array[i] = self[i] }
    self.static_array = new_static_array
  end
end
