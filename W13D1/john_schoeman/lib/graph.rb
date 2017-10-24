class Vertex
  attr_accessor :in_edges, :out_edges
  attr_reader :value

  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end

  def p_in_edges
    @in_edges.map { |edge| edge.from_vertex.value }
  end

  def p_out_edges
    @out_edges.map { |edge| edge.to_vertex.value }
  end
end

class Edge
  attr_accessor :from_vertex, :to_vertex
  attr_reader :cost

  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    from_vertex.out_edges << self
    @to_vertex = to_vertex
    to_vertex.in_edges << self
    @cost = cost
  end

  def destroy!
    @from_vertex.out_edges.delete(self)
    @from_vertex = nil
    @to_vertex.in_edges.delete(self)
    @to_vertex = nil
  end
end
