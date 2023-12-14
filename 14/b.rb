#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
chars = file.readlines.mchars
ans = 0

rows = chars.size

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
	return west(grid.transpose).transpose
end

def east(grid)
	return west(grid.map(&:reverse)).map(&:reverse)
end

def south(grid)
	return west(grid.transpose.map(&:reverse)).map(&:reverse).transpose
end

def spin(grid)
	return east(south(west(north(grid))))
end

grid = chars
#puts grid.map(&:join)

hits = { grid.md5 => 0 }
max = 0
min = 0
times = 1000000000
times.times.each do |i|
	#puts i + 1
	grid = spin(grid)
	if hits.key? grid.md5
		p 'MATCH', i, hits[grid.md5]
		max = i
		min = hits[grid.md5]
		break
	else
		hits[grid.md5] ||= i + 1
	end
end

magic = (1000000000-min) % (max-min+1) + min

grid = chars
magic.times.each do |i|
	grid = spin(grid)
end

#puts
#puts grid.map(&:join)

grid.eachi do |row,i|
	row.eachi do |r,j|
		ans += rows-i if r == 'O'
	end
end

puts ans.s.bold.yellow
puts 90928.s.bold.green

