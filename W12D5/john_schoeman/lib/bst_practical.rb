require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  arr = []
  in_order_traversal(tree_node, arr)
  arr[arr.length-k]
end

def in_order_traversal(tree_node, arr = [])
  in_order_traversal(tree_node.left, arr) if tree_node.left
  arr.push(tree_node)
  in_order_traversal(tree_node.right, arr) if tree_node.right
  return arr
end