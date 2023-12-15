#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
grids = file.readlines.split('')
ans = 0

def diffs(a, b)
	return a.size.a.count{|i| a[i]!=b[i]}
end

def reflect(grid)
	prev = []
	#puts grid.map(&:join)
	grid.eachi do |row, i|
		if diffs(row, prev) > 1
			prev = row
			next
		end

		smudge = false
		grid.size.times do |j|
			if i-j-1 < 0 or i + j >= grid.size
				return i if smudge
				break
			end
			next if grid[i+j] == grid[i-j-1]
			if not smudge and diffs(grid[i+j], grid[i-j-1]) == 1
				smudge = true
				next
			end
			break
		end
	end
	return 0
end

grids.each do |grid|
	grid = grid.map(&:chars)
	ans += reflect(grid.transpose)
	ans += 100*reflect(grid)
end

puts ans.s.bold.yellow
puts 29276.s.bold.green

