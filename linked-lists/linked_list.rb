class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
      @tail = node
    else
      @tail.next_node = node
      @tail = node
    end
  end

  def prepend(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
      @tail = node
    else
      node.next_node = @head
      @head = node
  end

  def size
    return 0 if @head.nil?
    pointer = @head
    size = 1
    until pointer == @tail
      size += 1
      pointer = pointer.next_node
    end
    size
  end

  def at(index)
    return nil if @head.nil? || index >= self.size || index < 0
    pointer = @head
    (1..index).each { |i| pointed = pointed.next_node }
    pointer
  end

  def pop
    case self.size
    when 0
      return nil
    when 1
      @head, @tail = nil, nil
    else 
      pop = self.at(self.size - 2)
      pop.next_node = nil
      @tail = pop
    end
  end

  def contains
    # returns true if the passed in value is in the list and otherwise returns false.
  end

  def find(value)
    # returns the index of the node containing value, or nil if not found.
  end

  def to_s
    # represent your LinkedList objects as strings, so you can print them out and preview them in the console. The format should be: ( value ) -> ( value ) -> ( value ) -> nil
  end

  def insert_at(value, index)
    #insert_at(value, index) that inserts the node with the provided value at the given index
  end

  def remove_at(index)
    #remove_at(index) that removes the node at the given index. (You will need to update the links of your nodes in the list when you remove a node.)
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end

list = LinkedList.new
