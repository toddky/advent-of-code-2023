#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
G = file.readlines.mchars
rows, cols = G.rows, G.cols unless G.rows == 0
#puts G.mjoin

nodes = {}

q = [[[1,1],Dir.down,1]]
while not q.empty?
	xy,dir,dist = q.shift
	c = G.point(*xy)
	if c.nil?
		ans = dist - 1
		next
	elsif c == '#'
		next
	elsif 'v<>^'.include? c
		next if dir != Dir.dirs[c]
	end
	backwards = [-dir[0], -dir[1]]
	D4.each do |dir_new|
		next if dir_new == backwards
		q.append([xy.move(dir_new), dir_new, dist+1])
	end
	#p q
end

puts ans.s.bold.yellow
puts 2334.s.bold.green
ans.clipboard unless ans == 0

