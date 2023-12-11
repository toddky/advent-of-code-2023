#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = file.readlines
chars = file.readlines.map(&:chars)
ans = 0

#size = 2
#size = 10
size = 1000000
rows = lines.map { |l| (l.chars.all? '.') ? size : 1 }
cols = chars.transpose.map { |l| (l.all? '.') ? size : 1 }
#p rows
#p cols

galaxies = []
chars.eachi do |line, i|
	line.eachi do |c, j|
		#p [i,j].inspect, c
		galaxies.append([i,j]) if c == '#'
	end
end

ans = 0
galaxies.eachi do |n,i|
	others = galaxies[(i+1)..-1]
	#p 'do', n, others
	others.each do |m|
		r1, r2 = [n[0], m[0]].sort
		c1, c2 = [n[1], m[1]].sort
		rsum = 0
		csum = 0
		rsum = rows[r1..(r2-1)].sum unless r1 == r2
		csum = cols[c1..(c2-1)].sum unless c1 == c2
		ans += rsum + csum
	end
end

puts ans.s.bold.yellow
puts 678626199476.s.bold.green

