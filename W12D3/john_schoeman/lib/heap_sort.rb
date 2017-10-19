require 'byebug'
require_relative "heap"

class Array
  def heap_sort!
    max_prc = Proc.new { |a,b| b <=> a }
    (1...length).each do |i|
      BinaryMinHeap.heapify_up(self, i, i) { |a, b| b <=> a }
    end

    (length - 1).downto(1) do |i|
      self[0], self[i] = self[i], self[0]
      BinaryMinHeap.heapify_down(self, 0, i) { |a, b| b <=> a }
    end
  end

end
