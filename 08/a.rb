#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || '1a.txt'
#file = ARGV[0] || '1b.txt'
ans = 0

dirs, lines = file.readlines.split('')
dirs = dirs.first
map = lines.map{|l| l.scan(/(\w\w\w)/).flatten}.map{|a| [a[0], a[1..2]]}.h

start = 'AAA'
while start != 'ZZZ'
	dirs.chars.each do |d|
		start = map[start]['LR'.index(d)]
		ans += 1
		break if start == 'ZZZ'
	end
end

puts ans.s.bold.yellow
puts 23147.s.bold.green

