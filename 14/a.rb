#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
chars = file.readlines.mchars
rows = chars.size
ans = 0

def west(grid)
	new_grid = []
	grid.each do |row|
		new_row = []
		temp = []
		row.each do |r|
			if r == '#'
				new_row.append(temp.sort.reverse)
				new_row.append(r)
				temp = []
				next
			end
			temp.append(r)
		end
		new_row.append(temp.sort.reverse)
		new_grid.append(new_row.flatten)
	end
	return new_grid
end

def north(grid)
	return west(grid.transpose)
end

grid = chars
#puts grid.transpose.mjoin
#puts grid.mjoin

grid = north(grid)
puts
puts grid.mjoin

grid.each do |row|
	row.eachi do |r,i|
		ans += rows-i if r == 'O'
	end
end

puts ans.s.bold.yellow
puts 109755.s.bold.green

