class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot = array.sample

    left = array.select { |el| el <= pivot }
    right = array.select { |el| el > pivot }

    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |a,b| a <=> b }
    return if length <= 1
    pivot_idx = self.partition(array, start, length, &prc)
    
    self.sort2!(array, start, pivot_idx - start, &prc)
    self.sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a,b| a <=> b }
    partition_idx = start + 1
    ((start + 1)...(start + length)).each do |i|
      case prc.call(array[start], array[i])
      when 1, 0
        array[i], array[partition_idx] = array[partition_idx], array[i]
        partition_idx += 1
      when -1
      end
    end
    array[start], array[partition_idx - 1] = array[partition_idx - 1], array[start]
    partition_idx - 1
  end
end
