class Tree
  attr_reader :root

  def initialize(arr = [])
    @root = build_tree(arr)
  end

  def build_tree(arr)
    return nil if !arr.is_a?(Array) || arr.empty?

    sorted_arr = arr.sort.uniq
    mid = sorted_arr.size / 2
    root_node = Node.new(sorted_arr[mid])
    root_node.left = build_tree(sorted_arr[0...mid])
    root_node.right = build_tree(sorted_arr[mid + 1..-1])
    root_node
  end

  def insert(value, node = @root)
    if value < node.data
      if node.left.nil?
        node.left = Node.new(value)
      else
        insert(value, node.left)
      end
    elsif value == node.data
      return
    else
      if node.right.nil?
        node.right = Node.new(value)
      else
        insert(value, node.right)
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end