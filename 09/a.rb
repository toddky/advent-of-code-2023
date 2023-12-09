#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
numbers = file.readlines.map(&:numbers)

def ext(n)
	diff = []
	prev = n[0]
	n[1..-1].each do |i|
		diff.append(i - prev)
		prev = i
	end
	return n[-1] if diff.all? 0
	return n[-1] + ext(diff)
end

ans = numbers.map {|n|ext(n)}.sum

puts ans.s.bold.yellow
puts 2038472161.s.bold.green

