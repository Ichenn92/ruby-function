require 'pry'
require_relative 'class/tree.rb'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

random_tree = Tree.new(Array.new(20) { rand(1..100) })
puts random_tree.balanced? ? 'tree is balanced' : "tree isn't balanced"
random_tree.pretty_print
puts "\nlevel order"
random_tree.level_order { |level| print "#{level} -> " }
puts "\npreorder"
random_tree.preorder { |level| print "#{level} -> " }
puts "\ninorder"
random_tree.inorder { |level| print "#{level} -> " }
puts "\npostorder"
random_tree.postorder { |level| print "#{level} -> " }
add_num = Array.new(5) { rand(101..200) }
puts "adding those new numbers #{add_num}"
add_num.map { |num| random_tree.insert(num) }
puts "\n\n"
p random_tree.data
puts random_tree.balanced? ? 'tree is balanced' : "tree isn't balanced"
random_tree.pretty_print
puts "\n\n"
print 'rebalancing'
(1..4).each do
  sleep(0.5)
  print '.'
end
puts "\n\n"

random_tree.rebalance!
puts random_tree.balanced? ? 'tree is now balanced' : 'tree still not balanced'
random_tree.pretty_print
puts "\nlevel order"
random_tree.level_order { |level| print "#{level} -> " }
puts "\npreorder"
random_tree.preorder { |level| print "#{level} -> " }
puts "\ninorder"
random_tree.inorder { |level| print "#{level} -> " }
puts "\npostorder"
random_tree.postorder { |level| print "#{level} -> " }

# binding.pry
# parents.map { |node| node.nil? ? 'nil' : node.value }
# childs.map { |node| node.nil? ? 'nil' : node.value }
