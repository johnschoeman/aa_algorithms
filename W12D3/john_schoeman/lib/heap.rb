require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |a,b| a <=> b }
  end

  def count
    @store.count
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    @store = BinaryMinHeap.heapify_down(@store, 0, @store.length, &@prc)
    val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    @store = BinaryMinHeap.heapify_up(@store, @store.length - 1, @store.length, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    [2 * parent_index + 1, 2 * parent_index + 2].map { |el| el < len ? el : nil }.compact
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a,b| a <=> b }

    while true
      children = self.child_indices(len, parent_idx)
      break if children.empty?
      
      if children.length == 1
        min_child_idx = children.first
      else
        case prc.call(array[children[0]], array[children[1]])
          when -1, 0
            min_child_idx = children[0]
          else
            min_child_idx = children[1]
        end
      end

      case prc.call(array[parent_idx], array[min_child_idx])
        when -1, 0
          break
        else
          parent = array[parent_idx]
          array[parent_idx] = array[min_child_idx]
          array[min_child_idx] = parent
          parent_idx = min_child_idx
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |a,b| a <=> b }

    while true
      break if child_idx == 0
      parent_idx = self.parent_index(child_idx)
      case prc.call(array[parent_idx], array[child_idx])
        when -1, 0
          break
        else
          parent = array[parent_idx]
          array[parent_idx] = array[child_idx]
          array[child_idx] = parent
          child_idx = parent_idx
      end
    end
    array
  end
end
