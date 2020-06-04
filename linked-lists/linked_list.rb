require 'pry'

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
    (1..index).each { |i| pointer = pointer.next_node }
    pointer
  end

  def pop
    case self.size
    when 0
      return nil
    when 1
      @head, @tail = nil, nil
    else
      previous_node = @tail
      pop = self.at(self.size - 2)
      pop.next_node = nil
      @tail = pop
      previous_node
    end
  end

  def contains?(value)
    (0...self.size).each do |index|
      return true if self.at(index).value == value
    end
    return false
  end

  def find(value)
    (0...self.size).each do |index|
      return index if self.at(index).value == value
    end
    return nil
  end

  def to_s
    string = ''
    (0...self.size).each { |index| string += "#{self.at(index).value} -> " }
    string += 'nil'
  end

  def insert_at(value, index)
    if (0...self.size).include?(index)
      new_node = Node.new(value)
      left_node = self.at(index - 1)
      right_node = self.at(index)
      if index == 0
        @head = new_node
        new_node.next_node = right_node
      elsif index == self.size - 1
        @tail = new_node
        left_node.next_node = new_node
        new_node.next_node = right_node
      else
        left_node.next_node = new_node
        new_node.next_node = right_node
      end
    else
      return nil
    end
  end

  def remove_at(index)
    if index == 0
      @head = self.at(1)
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

linked_list = LinkedList.new

linked_list.append(3)
linked_list.append(4)
linked_list.append(7)
linked_list.append(9)
linked_list.append(12)
linked_list.append(15)

puts linked_list

linked_list.prepend(1)

puts linked_list

puts linked_list.size

puts linked_list.head.value
puts linked_list.tail.value

puts linked_list.at(2).value
p linked_list.pop.value
puts linked_list.tail.value

puts linked_list.contains?(6)
puts linked_list.contains?(9)

puts linked_list.find(3)
p linked_list.find(15)

linked_list.insert_at(6, 3)
puts linked_list

p linked_list.remove_at(1)
puts linked_list
