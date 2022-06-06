# lib/main.rb

require_relative 'tree'
require_relative 'node'

arr = Array.new(15) { rand(1..100) }

tr = Tree.new(arr)
tr.pretty_print
puts "Tree is balanced? : #{tr.balanced?}"
puts "In-order: #{tr.inorder}"
puts "Pre-order: #{tr.preorder}"
puts "Post-order: #{tr.postorder}"
puts "Level-order: #{tr.level_order}"

tr.insert(190)
tr.insert(299)
tr.insert(101)
tr.insert(234)
tr.insert(1000)
tr.insert(-1)
tr.insert(-2)

tr.pretty_print
puts "Tree is balanced? : #{tr.balanced?}"
puts "In-order: #{tr.inorder}"
puts "Pre-order: #{tr.preorder}"
puts "Post-order: #{tr.postorder}"
puts "Level-order: #{tr.level_order}"

tr.rebalance!

tr.pretty_print
puts "Tree is balanced? : #{tr.balanced?}"
puts "In-order: #{tr.inorder}"
puts "Pre-order: #{tr.preorder}"
puts "Post-order: #{tr.postorder}"
puts "Level-order: #{tr.level_order}"
