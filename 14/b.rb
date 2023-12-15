#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
chars = file.readlines.mchars
rows = chars.size
ans = 0

def west(grid)
	grid.map do |row|
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
		new_row.flatten
	end
end
def north(grid); return west(grid.ccw).cw; end
def east(grid);  return west(grid.mreverse).mreverse; end
def south(grid); return west(grid.cw).ccw; end
def spin(grid);  return east(south(west(north(grid)))); end

grid = chars
#puts grid.map(&:join)

seen = { grid => 0 }
value = 0
times = 1000000000
times.times.each do |i|
	#puts i + 1
	grid = spin(grid)
	if seen.key? grid
		p 'MATCH', i, seen[grid]
		max = i
		min = seen[grid]
		value = (times-min) % (max-min+1) + min
		break
	end
	seen[grid] ||= i + 1
end

grid = seen.key(value)
#puts grid.map(&:join)

grid.eachi do |row,i|
	row.eachi do |r,j|
		ans += rows-i if r == 'O'
	end
end

puts ans.s.bold.yellow
puts 90928.s.bold.green

