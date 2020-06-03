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

  def contains(value)
	(0...self.size).each {|index| return true if self.at(index) == value}
	return false
  end

  def find(value)
	(0...self.size).each {|index| return index if self.at(index) == value}
	return nil
    # returns the index of the node containing value, or nil if not found.
  end

  def to_s
	string = ""
	(0...self.size).each{ |index| string += "#{self.at(index)} -> "}
	string += "nil"
    # represent your LinkedList objects as strings, so you can print them out and preview them in the console. The format should be: ( value ) -> ( value ) -> ( value ) -> nil
  end

  def insert_at(value, index)
	if (0...self.size).include?(index)
	  existing_node = self.at(index)
	  new_node = Node.new(value)
	  new_node.next_node = existing_node.next_node
	  existing_node.next_node = new_node
	  if index == 0
	    @head = new_node
	  elsif index == self.size - 1
	    @tail = new_node
	  end
	else
	  return nil
	end
  end

  def remove_at(index)
	if index == 0
		@head = self.at(1)
		self.at(0).next_node = nil
	elsif (1...self.size).include?(index)
	  existing_node = self.at(index)
	  left_node = self.at(index - 1)
	  left_node.next_node = existing_node.next_node
	  existing_node.next_node = nil
	else
	  return nil
	end
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
