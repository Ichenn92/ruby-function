require_relative 'node.rb'

class Tree
  attr_accessor :data, :root
  include Comparable

  def initialize(array)
    @data = array.uniq
    @root = build_tree(@data)
  end

  def build_tree(array)
    root = Node.new(array.shift)
    array.each do |value|
      node = Node.new(value)
      compare(root, node)
    end
    root
  end

  def insert(value)
    node = Node.new(value)
    compare(root, value)
  end

  def delete
    #method which accepts a value to insert/delete (you’ll have to deal with
    #several cases for delete such as when a node has children or not).
  end
end
