require_relative 'node.rb'

class Tree
  attr_accessor :data, :root
  include Comparable

  def initialize(array)
    @data = array.uniq
    @root = build_tree
  end

  def build_tree
    array = @data.dup
    root = Node.new(array.shift)
    array.each do |value|
      node = Node.new(value)
      compare(root, node)
    end
    root
  end

  def insert(value)
    node = Node.new(value)
    compare(root, node)
  end

  def delete(value, parent_pointer = @root)
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
  
  def level_order(queue = [@root])
	  until queue.empty?
	    yield(queue[0].value) if block_given?
	    next_node = queue.pop
	    queue.push(next_node.left_child) unless next_node.left_child.nil?
	    queue.push(next_node.right_child) unless next_node.right_child.nil?
	  end
  end
  
  def level_order_rec(queue = [@root])
	  queue_child = []
	  queue.each do |node| yield(node.value)
	    queue_child.push(next_node.left_child) unless next_node.left_child.nil?
	    queue_child.push(next_node.right_child) unless next_node.right_child.nil?
	  end
	  level_order_rec queue_child unless queue_child.empty?
  end
end
