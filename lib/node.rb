class Node
  include Comparable

  attr_reader :data
  attr_accessor :left, :right
  
  def <=>(other)
    data <=> other.data
  end

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end