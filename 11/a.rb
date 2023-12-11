#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = file.readlines

space = []
lines.eachi do |line, i|
	space.append(line.chars)
	space.append(line.chars) if line.chars.all? '.'
end

space2 = []
space.transpose.eachi do |line, i|
	space2.append(line)
	space2.append(line) if line.all? '.'
end
space2 = space2.transpose
#puts space2.map(&:join)

galaxies = []
space2.eachi do |line, i|
	line.eachi do |c, j|
		galaxies.append([i,j]) if c == '#'
	end
end
#p galaxies

ans = 0
galaxies.eachi do |n,i|
	others = galaxies[(i+1)..-1]
	others.each do |m|
		v = (n[0]-m[0]).abs + (n[1]-m[1]).abs
		ans += v
	end
end

puts ans.s.bold.yellow
puts 9556712.s.bold.green

