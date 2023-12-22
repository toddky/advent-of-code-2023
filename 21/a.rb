#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
G = file.readlines.mchars
rows, cols = G.rows, G.cols unless G.rows == 0
ans = 0

row = G.index{|r| r.include? 'S'}
col = G.select{|r| r.include? 'S'}[0].index('S')

steps = 64
visited = Array.newa(rows, cols, 0)

q = [[row,col]]
(steps+1).times do
	nq = []
	while not q.empty?
		xy = q.shift
		c = G.point(*xy)
		next if c.nil? or c == '#' or visited.point(*xy) == 1
		visited[xy.x][xy.y] = 1
		nq.push(xy.up, xy.down, xy.left, xy.right)
	end
	q = nq
end

m = (row + col) % 2
visited.eachi do |row,x|
	row.eachi do |v,y|
		ans += v if (x+y)%2 == m
	end
end

def pretty_print(g,v)
	g.eachi do |row,x|
		row.eachi do |c,y|
			if v[x][y] == 1
				print c.green
			else
				print c
			end
		end
		puts
	end
end
pretty_print(G,visited)

puts ans.s.bold.yellow
puts 3722.s.bold.green
ans.clipboard unless ans == 0

