class BSTNode
  attr_reader :value
  attr_accessor :left, :right, :parent

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
  end
end
