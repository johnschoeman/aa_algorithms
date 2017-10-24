# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'graph'
require_relative 'topological_sort'
require 'byebug'

def install_order(arr)
  verticies = []
  
  # build verticies
  arr.each do |el|
    unless verticies.any? { |vert| vert.value == el[0]}
      verticies << Vertex.new(el[0])
    end
    unless verticies.any? { |vert| vert.value == el[1]}
      verticies << Vertex.new(el[1])
    end
  end

  # fills in nodes with no dependencies
  min, max = verticies.map { |v| v.value }.minmax
  (min..max).each do |i|
    unless verticies.any? { |vert| vert.value == i}
      verticies << Vertex.new(i)
    end
  end

  # build edges
  arr.each do |el|
    to_vert = verticies.find { |vert| vert.value == el[0] }
    from_vert = verticies.find { |vert| vert.value == el[1] }
    e = Edge.new(from_vert, to_vert)
  end

  sorted_verticies = topological_sort(verticies)
  return sorted_verticies.map { |v| v.value }
end
