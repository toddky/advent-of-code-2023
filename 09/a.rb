#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
numbers = file.readlines.map(&:numbers)

def ext(n)
	return 0 if n.all? 0
	diff = n[1..-1].mapi{|x,i| x-n[i]}
	return n[-1] + ext(diff)
end

ans = numbers.map {|n|ext(n)}.sum

puts ans.s.bold.yellow
puts 2038472161.s.bold.green

