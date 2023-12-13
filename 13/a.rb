#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
grids = file.readlines.split('')
ans = 0

def reflect(grid)
	prev = []
	#puts grid.map(&:join)
	grid.eachi do |row, i|
		if row != prev
			prev = row
			next
		end
		grid.size.times do |j|
			return i if i-j-1 < 0 or i + j >= grid.size
			next if grid[i+j] == grid[i-j-1]
			break
		end
	end
	return 0
end

grids.each do |grid|
	grid = grid.map { |row| row.chars }
	ans += reflect(grid.transpose)
	ans += 100*reflect(grid)
end

puts ans.s.bold.yellow
puts 27300.s.bold.green

