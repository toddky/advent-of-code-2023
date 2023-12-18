#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
start =  Process.clock_gettime(Process::CLOCK_MONOTONIC)
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
words = file.readlines.map(&:words)
grid = file.readlines.mchars
rows, cols = grid.rows, grid.cols unless grid.rows == 0
ans = 0

r = [0,1]
l = [0,-1]
u = [-1,0]
d = [1,0]

dirs = {
	'R' => r,
	'L' => l,
	'U' => u,
	'D' => d,
}

holes = []
x = 0
y = 0
words.each do |dir, dist, rgb|
	offset = dirs[dir]
	dist = dist.i * 2
	dist.times do
		x += offset[0]
		y += offset[1]
		holes.append([x,y,rgb])
	end
end

#p holes
row_min = holes.transpose[0].min.abs
col_min = holes.transpose[1].min.abs

holes = holes.map{|x,y,rgb| [x+row_min,y+row_min,rgb]}

rows = holes.transpose[0].max + 1
cols = holes.transpose[1].max + 1

grid = Array.new(rows+1) {Array.new(cols+1,0)}
holes.each do |x,y,rgb|
	grid[x][y] = 1
end

#puts
#puts grid.mjoin

def ff(grid,x,y)
	q = [[x,y]]
	while not q.empty?
		x, y = q.pop
		next if x < 0 or x >= grid.rows or y < 0 or y >= grid.cols or grid[x][y] != 0
		grid[x][y] = 2
		q.append([x+1,y])
		q.append([x-1,y])
		q.append([x,y+1])
		q.append([x,y-1])
	end
	return grid

end
# REVISIT: Unhack this hardcoded value by padding the border and setting this to 0,0
fgrid = ff(grid.mdup,1,1)
#puts
#puts fgrid.mjoin

grid = fgrid.each_with_index.select { |_, i| i.even? }.map do |row, _|
	row.each_with_index.select { |_, j| j.even? }.map(&:first)
end
#puts
#puts grid.mjoin

ans = grid.flatten.count { |a| a != 2 }

puts ans.s.bold.yellow
puts 45159.s.bold.green
ans.clipboard
stop = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Finished in #{((stop - start) * 1000).round(0)} ms"

