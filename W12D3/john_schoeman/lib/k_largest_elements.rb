require_relative 'heap'

# using a max heap
# O(nlog(n-k))
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

# using a min heap
# O(nlogk)
def k_largest_elements2(array, k) 
  result = BinaryMinHeap.new
  k.times do
    result.push(array.pop)
  end
  until array.empty?
    result.push(array.pop)
    result.extract
  end
  result.store
end
