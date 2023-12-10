#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
#file = ARGV[0] || '2.txt'
lines = file.readlines
words = file.readlines.map(&:words)
numbers = file.readlines.map(&:numbers)
numbers = file.readlines.map(&:numbers).map(&:abs)
chars = file.readlines.map(&:chars)
ans = 0

lines.mapi { |line, i| line }
lines.eachi do |line, i|
end
p lines

puts lines


row = lines.index{|line| line.index('S') }
col = lines[row].index('S')
p [row, col]

$offset = {
	"N" => [-1,0],
	"E" => [0,1],
	"S" => [1,0],
	"W" => [0,-1],
}
p $offset

$dir = {
	'|' => {'N'=>'N','S'=>'S'},
	'-' => {'E'=>'E','W'=>'W'},
	'L' => {'S'=>'E','W'=>'N'},
	'J' => {'S'=>'W','E'=>'N'},
	'7' => {'N'=>'W','E'=>'S'},
	'F' => {'N'=>'E','W'=>'S'},
	'.' => {},
	'S' => {},
}

$grid = lines
def travel(row,col,d)
	dist = 1
	row += $offset[d][0]
	col += $offset[d][1]
	here = $grid[row][col]
	while here != 'S'
		d = $dir[here][d]
		return 0 if d == nil
		row += $offset[d][0]
		col += $offset[d][1]
		here = $grid[row][col]
		p d, here
		dist += 1
	end
	return dist
end

max = 0
'NESW'.chars.each do |d|
	dist = travel(row,col,d)
	max = dist if dist > max
end

ans = max / 2




puts ans.s.bold.yellow
puts 0.s.bold.green

