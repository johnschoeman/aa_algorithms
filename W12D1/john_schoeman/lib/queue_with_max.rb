require 'byebug'
# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :max_store, :store

  def initialize
    @max_store = RingBuffer.new
    @store = RingBuffer.new
  end

  def enqueue(val)
    new_max_store = RingBuffer.new
    (0...@max_store.length).each do |i|
      new_max_store.unshift(@max_store[i]) if @max_store[i] >= val
    end
    @max_store = new_max_store
    @max_store.unshift(val)
    @store.unshift(val)
  end

  def dequeue
    result = @store.pop
    if @max_store.length != 0 && result == @max_store[@max_store.length - 1]
      @max_store.pop
    end
    result
  end

  def max
    if @max_store.length != 0
      @max_store[@max_store.length - 1]
    end
  end

  def length
    @store.length
  end

end
