require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  vert_queue = []
  vert_sorted = []

  vertices.each do |vert|
    if vert.in_edges.empty?
      vert_queue.unshift(vert)
    end
  end

  until vert_queue.empty?
    curr_vert = vert_queue.pop
    vertices.delete(curr_vert)
    vert_sorted << curr_vert
    curr_vert.out_edges.each do |edge|
      if edge.to_vertex.in_edges.count == 1
        vert_queue.unshift(edge.to_vertex)
      end
    end
    curr_vert.out_edges.each do |edge|
      edge.destroy!
    end
  end
  vertices.empty? ? vert_sorted : []
end

def tarians_sort
  
end