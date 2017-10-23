# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.

require_relative 'bst_node'

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root
      curr_node = @root
    else
      @root = BSTNode.new(value)
      return @root
    end
    while true
      case value <=> curr_node.value
      when -1
        if curr_node.left.nil?
          curr_node.left = BSTNode.new(value, curr_node)
          return curr_node.left
        else
          curr_node = curr_node.left
        end
      when 0
        if curr_node.left.nil?
          curr_node.left = BSTNode.new(value, curr_node)
          return curr_node.left
        elsif curr_node.right.nil?
          curr_node.right = BSTNode.new(value, curr_node)
          return curr_node.right
        else
          curr_node = [curr_node.left, curr_node.right].sample
        end
      when 1
        if curr_node.right.nil?
          curr_node.right = BSTNode.new(value, curr_node)
          return curr_node.right
        else
          curr_node = curr_node.right
        end
      end
    end
  end

  def find(value, tree_node = @root)
    while true
      case value <=> tree_node.value
      when -1
        tree_node = tree_node.left
        return nil if tree_node.nil?
      when 0
        return tree_node
      when 1
        tree_node = tree_node.right
        return nil if tree_node.nil?
      end
    end
  end

  def delete(value)
    node_to_delete = find(value)
    return if node_to_delete.nil?

    if node_to_delete.left.nil? && node_to_delete.right.nil?
      remove(node_to_delete) 
      return
    end

    if node_to_delete.left && node_to_delete.right.nil?
      replace(node_to_delete, node_to_delete.left)
    end

    if node_to_delete.right && node_to_delete.left.nil?
      replace(node_to_delete, node_to_delete.right)
    end

    if node_to_delete.left && node_to_delete.right
      max = maximum(node_to_delete.left)
      if max.left.nil?
        replace(node_to_delete, max)
        remove(node_to_delete)
      else
        max.parent.right = max.left
        replace(node_to_delete, max)
        remove(node_to_delete)
      end
 
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    while true
      if tree_node.right.nil?
        return tree_node
      else
        tree_node = tree_node.right
      end
    end
  end

  def depth(tree_node = @root)
    return 0 if tree_node.left.nil? && tree_node.right.nil?
    return depth(tree_node.left) + 1 if tree_node.right.nil?
    return depth(tree_node.right) + 1 if tree_node.left.nil?
    return [depth(tree_node.left), depth(tree_node.right)].max + 1
  end 

  def is_balanced?(tree_node = @root)
    if tree_node.left && tree_node.right
      return false if (depth(tree_node.left) - depth(tree_node.right)).abs > 1
      return false unless is_balanced?(tree_node.left)
      return false unless is_balanced?(tree_node.right)
    end
    true
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr) if tree_node.right
    return arr
  end


  private
  # optional helper methods go here:
  def remove(node)
    if node.parent.nil?
      @root = nil
      return
    end
    if node.parent.left == node
      node.parent.left = nil
    elsif node.parent.right == node
      node.parent.right = nil
    end
  end

  def replace(node_to_replace, node)
    if node_to_replace.parent.left == node_to_replace
      node_to_replace.parent.left = node
    elsif node_to_replace.parent.right == node_to_replace
      node_to_replace.parent.right = node
    end
  end

end
