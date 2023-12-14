#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'
require 'digest'

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

def md5(grid)
	return Digest::MD5.hexdigest(grid.inspect)
end

grid = chars
#puts grid.map(&:join)

hits = { md5(grid) => 0 }
max = 0
min = 0
times = 1000000000
times.times.each do |i|
	#puts i + 1
	grid = spin(grid)
	if hits.key? md5(grid)
		p 'MATCH', i, hits[md5(grid)]
		max = i
		min = hits[md5(grid)]
		break
	else
		hits[md5(grid)] ||= i + 1
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

