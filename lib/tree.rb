class Tree
  attr_accessor :root

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

  def find(value, node = @root)
    if value == node.data
      puts node.data
      node
    elsif value < node.data
      if node.left
        find(value, node.left)
      else
        puts "#{value} not found"
      end
    else
      if node.right
        find(value, node.right)
      else
        puts "#{value} not found"
      end
    end
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      if node.left.nil?
        node = node.right
        node
      elsif node.right.nil?
        node = node.left
        node
      else
        temp = min_value_node(node.right)
        node.data = temp.data
        node.right = delete(temp.data, node.right)
      end
    end
    node
  end

  def min_value_node(node)
    current = node
    until current.left.nil?
      current = current.left
    end
    current
  end

  # Recursive version of level_order
  # def level_order(queue = [@root], &block)
  #   block.call(queue.first)
  #   queue << queue.first.left unless queue.first.left.nil?
  #   queue << queue.first.right unless queue.first.right.nil?
  #   queue.shift
  #   level_order(queue, &block) until queue.empty?
  # end

  def level_order(queue = [@root])
    output_arr = []
    while queue.first
      if block_given?
        yield(queue.first)
      else
        output_arr << queue.first.data
      end
      queue << queue.first.left if queue.first.left
      queue << queue.first.right if queue.first.right
      queue.shift
    end
    output_arr
  end

  def inorder(node = @root, &block)
    return unless node

    if block_given?
      inorder(node.left, &block) if node.left
      block.call node
      inorder(node.right, &block) if node.right
    else
      arr = []
      arr += inorder(node.left) if node.left
      arr << node.data
      arr += inorder(node.right) if node.right
      arr
    end
  end

  def preorder(node = @root, &block)
    return unless node

    if block_given?
      block.call node
      preorder(node.left, &block)
      preorder(node.right, &block)
    else
      arr = []
      arr << node.data
      arr += preorder(node.left) if node.left
      arr += preorder(node.right) if node.right
      arr
    end
  end

  def postorder(node = @root, &block)
    return unless node

    if block_given?
      postorder(node.left, &block)
      postorder(node.right, &block)
      block.call node
    else
      arr = []
      arr += postorder(node.left) if node.left
      arr += postorder(node.right) if node.right
      arr << node.data
      arr
    end
  end

  def height(node)
    return -1 unless node

    return 0 unless node.left || node.right

    left_height = node.left ? height(node.left,) + 1 : 0
    right_height = node.right ? height(node.right) + 1 : 0
    [left_height, right_height].max
  end

  def depth(node, top_node = @root)
    return -1 unless node

    if node.data == top_node.data
      0
    elsif node.data < top_node.data
      1 + depth(node, top_node.left)
    else
      1 + depth(node, top_node.right)
    end
  end

  def balanced?(node = @root)
    return true if !node

    (height(node.left) - height(node.right)).abs <= 1\
      && balanced?(node.left)\
      && balanced?(node.right)
  end

  def rebalance!
    new_arr = inorder
    @root = build_tree(new_arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '???   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '????????? ' : '????????? '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '???   '}", true) if node.left
  end
end