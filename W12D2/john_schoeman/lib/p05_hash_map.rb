require 'byebug'
require_relative 'p02_hashing'
require_relative 'p04_linked_list'

include Enumerable

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    res = @store[key.hash % num_buckets].include?(key)
    res
  end

  def set(key, val)
    if include?(key)
      @store[key.hash % num_buckets].update(key, val) 
    else
      resize! if @count == num_buckets
      @count += 1
      @store[key.hash % num_buckets].append(key, val)
    end
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    @store[key.hash % num_buckets].remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each do |item|
        yield(item.key, item.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(2 * num_buckets) { LinkedList.new }
    each do |key, val|
      new_store[key.hash % new_store.length].append(key, val)
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
