# lib/main.rb

require_relative 'tree'
require_relative 'node'

arr = Array.new(15) { rand(1..100) }

tr = Tree.new(arr)

tr.pretty_print