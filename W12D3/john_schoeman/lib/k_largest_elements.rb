require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new { |a,b| b <=> a }
  result = []
  array.each do |el|
    heap.push(el)
    if heap.count > array.length - k
      result << heap.extract
    end
  end

  result
end
