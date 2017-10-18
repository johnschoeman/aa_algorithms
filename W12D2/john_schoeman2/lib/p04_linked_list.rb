require 'byebug'
include Enumerable
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
    self
  end
end

class LinkedList
  def initialize
    @head = Node.new(:head, nil)
    @tail = Node.new(:tail, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    return @head.next unless empty?
    @head
  end

  def last
    return @tail.prev unless empty?
    @tail
  end

  def empty?
    @head.next.key == :tail
  end

  def get(key)
    node = get_node(key)
    node.val if node
  end

  def get_node(key)
    return nil if empty?
    curr_node = @head
    while true
      curr_node = curr_node.next
      return curr_node if curr_node.key == key
      return nil if curr_node == @tail
    end
  end

  def include?(key)
    !!get_node(key)
  end
  
  def append(key, val)
    new_node = Node.new(key,val)
    new_node.prev = @tail.prev
    @tail.prev.next = new_node
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    node = get_node(key)
    if node
      node.key = key
      node.val = val
    end
  end

  def remove(key)
    node = get_node(key)
    node.remove if node
  end

  def each
    return nil if empty?
    curr_node = @head
    while true
      curr_node = curr_node.next
      break if curr_node == @tail
      yield(curr_node)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
