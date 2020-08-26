require_relative 'node.rb'

class Tree
  attr_accessor :data, :root
  include Comparable

  def initialize(array)
    @data = array.uniq
    @root = build_tree
  end

  def build_tree(array = @data.dup)
    root = Node.new(array.shift)
    array.each do |value|
      node = Node.new(value)
      compare(root, node)
    end
    root
  end

  def insert(value)
    @data.push(value)
    node = Node.new(value)
    compare(root, node)
  end

  def delete(value, parent_pointer = @root)
    @data.delete(value)
    node = find(value)
    return nil if node.nil?

    unless node == @root
      parent = find_parent(value)
      parent_pointer =
        value < parent.value ? parent.left_child : parent.right_child
    end

    if node.left_child.nil?
      return parent_pointer = node.right_child
    elsif node.right_child.nil?
      return parent_pointer = node.left_child
    else
      parent_pointer = node.left_child
      compare(parent_pointer, node.right_child)
    end
  end

  def find(value, node = @root)
    if value == node.value
      return node
    elsif value < node.value
      return nil if node.left_child.nil?
      find(value, node.left_child)
    elsif value > node.value
      return nil if node.right_child.nil?
      find(value, node.right_child)
    end
  end

  def find_parent(value)
    value == @root.value ? nil : find_parent_rec(value)
  end

  def find_parent_rec(value, node = @root)
    value_left_child = node.left_child.nil? ? nil : node.left_child.value
    value_right_child = node.right_child.nil? ? nil : node.right_child.value

    if value == value_left_child || value == value_right_child
      return node
    elsif value < node.value
      value_left_child.nil? ? nil : find_parent_rec(value, node.left_child)
    elsif value > node.value
      value_right_child.nil? ? nil : find_parent_rec(value, node.right_child)
    end
  end

  def level_order(queue = [@root], no_block = [])
    until queue.empty?
      if block_given?
        yield(queue.map(&:value))
      else
        no_block.push(queue.map(&:value))
      end
      (0...queue.count).each do
        next_node = queue.shift
        queue.push(next_node.left_child) unless next_node.left_child.nil?
        queue.push(next_node.right_child) unless next_node.right_child.nil?
      end
    end
    no_block
  end

  def level_order_rec(queue = [@root], no_block = [], &block)
    queue_child = []
    if block_given?
      block.call(queue.map(&:value))
    else
      no_block.push(queue.map(&:value))
    end

    queue.each do |node|
      queue_child.push(node.left_child) unless node.left_child.nil?
      queue_child.push(node.right_child) unless node.right_child.nil?
    end
    level_order_rec(queue_child, no_block, &block) unless queue_child.empty?
    no_block
  end

  %i[preorder inorder postorder].each do |method|
    define_method(method) do |node = @root, no_block = [], &block|
      parent =
        Proc.new { block ? block.call(node.value) : no_block << node.value }

      parent.call if method == :preorder
      unless node.left_child.nil?
        send(method, node.left_child, no_block, &block)
      end
      parent.call if method == :inorder
      unless node.right_child.nil?
        send(method, node.right_child, no_block, &block)
      end
      parent.call if method == :postorder
      no_block
    end
  end

  def depth(node)
    node.nil? ? 0 : level_order([node]).size
  end

  def balanced?(root = @root)
    left_height = depth(root.left_child)
    right_height = depth(root.right_child)
    (-1..1).include?(left_height - right_height)
  end

  def rebalance!
    result = rebalance_ordering(@data.dup.sort)
    @root = build_tree(result)
  end

  def rebalance_ordering(tree, result = [])
    return if tree.size == 0
    middle = tree.size / 2
    result.push tree.slice!(middle)
    rebalance_ordering(tree[0...middle], result)
    rebalance_ordering(tree[(middle)..-1], result)
    result
  end

  def display_vertical
    cell = '      '
    grid_height = depth(@root)
    grid_width = 2**(grid_height - 1) * cell.length
    parents = [@root]

    factor_spacing = 0
    (1...grid_height).each { factor_spacing = factor_spacing * 2 + 1 }

    (0...grid_height).each do |floor|
      num_cell = 2**floor
      normal_space = factor_spacing * cell.length
      outside_spacing =
        (
          grid_width -
            (factor_spacing * (num_cell - 1) + num_cell) * cell.length
        ) / 2

      if floor == 0
        print ' ' * outside_spacing
        print '('
        print '%4s' % [root.value]
        print ')'
      else
        childs = []
        parents.map do |parent|
          unless parent.nil?
            childs << parent.left_child
            childs << parent.right_child
          else
            childs << nil << nil
          end
        end
        parents = childs.dup

        print ' ' * outside_spacing

        (num_cell).times do
          next_cell = childs.shift
          if next_cell.nil?
            print cell
          else
            print '('
            print '%4s' % [next_cell.value]
            print ')'
          end
          print ' ' * normal_space
        end
      end
      print "\n"
      factor_spacing /= 2
    end
  end

  def display_horizontal(node = @root, prefix="", is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right_child
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.value.to_s}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left_child
  end
end
