require "byebug"
require_relative "static_array"

class RingBuffer
  attr_reader :length
  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" unless check_index(index)
    self.store[(self.start_idx + index) % self.capacity]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" unless check_index(index)
    self.store[(self.start_idx + index) % self.capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if self.length == 0
    result = self[self.length - 1]
    self[self.length - 1] = nil
    self.length -= 1
    result
  end

  # O(1) ammortized
  def push(val)
    if self.length == self.capacity
      self.resize!
    end
    self.length += 1
    self[length - 1] = val
  end

  # O(1)
  def shift
    result = self[0]
    self[0] = nil
    self.start_idx = (self.start_idx + 1) % self.capacity
    self.length -= 1
    result
  end

  # O(1) ammortized
  def unshift(val)
    if self.length == self.capacity
      self.resize!
    end
    self.length += 1
    self.start_idx = (self.start_idx - 1) % self.capacity
    self[0] = val
  end

  def pretty_print
    result = "["
    return "[]" if self.length == 0
    (0...self.length - 1).each do |idx|
      result += "#{self[idx]},"
    end
    result += "#{self[self.length - 1]}]"
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    (-self.length...self.length).include?(index)    
  end

  def resize!
    new_store = StaticArray.new(self.capacity * 2)
    (0...self.capacity).each do |i|
      new_store[i] = self[i]
    end
    self.capacity *= 2
    self.start_idx = 0
    self.store = new_store
  end
end
