#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = file.readlines
words = file.readlines.map(&:words)
numbers = file.readlines.map(&:numbers)
numbers = file.readlines.map(&:numbers).map(&:abs)
chars = file.readlines.map(&:chars)
ans = 0

grids = lines.slice_when { |a| a.empty? }.to_a.map{|a| a.reject(&:empty?)}
#p grids

def diff(a, b)
	c = 0
	a.eachi do |x,i|
		c += 1 if x != b[i]
	end
	return c
end

#p diff(["#", ".", "#", "#", "#", "#", "#", "#", "."], ["#", ".", "#", "#", "#", "#", "#", "#", "."])
#p diff([".", ".", "#", "#", "#", "#", "#", "#", "."], ["#", ".", "#", "#", "#", "#", "#", "#", "."])
#p diff([".", "#", "#", "#", "#", "#", "#", "#", "."], ["#", ".", "#", "#", "#", "#", "#", "#", "."])
#exit

def reflect(grid)
	prev = []
	#puts grid.map(&:join)
	grid.eachi do |row, i|
		if diff(row, prev) > 1
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
			if not smudge and diff(grid[i+j], grid[i-j-1]) == 1
				smudge = true
				next
			end
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
puts 29276.s.bold.green

