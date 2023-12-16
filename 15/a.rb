#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
csv = file.readlines.map{|line| line.split(',')}

def h(str)
	str.ascii.reduce(0) { |v,c| v = (v+c) * 17 % 256 }
end
#p h('HASH')

ans = csv[0].map{|a| h(a)}.sum

puts ans.s.bold.yellow
puts 519041.s.bold.green

