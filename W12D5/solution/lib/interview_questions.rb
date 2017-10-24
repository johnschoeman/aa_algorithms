# Post Order Traversal:


# Pre Order Traversal:


# LCA: 
# In a binary search tree, an *ancestor* of a `example_node` is a node 
# that is on a higher level than `example_node`, and can be traced directly 
# back to `example_node` without going up any levels. (I.e., this is 
# intuitively what you think an ancestor should be.) Every node in a binary 
# tree shares at least one ancestor -- the root. In this exercise, write a 
# function that takes in a BST and two nodes, and returns the node that is the 
# lowest common ancestor of the given nodes. Assume no duplicate values.



def in_order(root_node) 
  node_stack = [root_node]
  curr_node = nil
  visted_nodes = []
  in_order_array =  []
  until node_stack.empty?
    curr_node = node_stack.pop
    node_stack.push(curr_node.right) if curr_node.right
    node_stack.push(curr_node.left) if curr_node.left
    visted_nodes.push(curr_node)
  end
  return visted_nodes
end

###
# in order iterative algorigthm
# 1. create an empty node_stack
# 2. init curr node as the root
# 3. push the current into the stack, and set current as current.left until current is null.
# 4. if current is null and stack stack isn't empty
#   1. pop top item from stack and print
#   2. set current to popped item.right
#   3. go back to step 3
# 5. if current is null and stack is empty then we are done.
###