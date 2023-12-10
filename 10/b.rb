#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
#file = ARGV[0] || '2.txt'
#file = ARGV[0] || '3.txt'
#file = ARGV[0] || '4.txt'
#file = ARGV[0] || '5.txt'
#file = ARGV[0] || '6.txt'

lines = file.readlines
words = file.readlines.map(&:words)
numbers = file.readlines.map(&:numbers)
numbers = file.readlines.map(&:numbers).map(&:abs)
chars = file.readlines.map(&:chars)
ans = 0

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

class String
	#┌─┐
	#│ │
	#└─┘
	def box()
		self.gsub('|','│').gsub('-','─')
			.gsub('L','└').gsub('J','┘')
			.gsub('7','┐').gsub('F','┌')
			.gsub('.',' ')
	end
end


box = '█'

$grid = lines
def travel(row,col,d)
	path = []
	dist = 1
	row += $offset[d][0]
	col += $offset[d][1]
	here = $grid[row][col]
	path.append([row,col])
	while here != 'S'
		d = $dir[here][d]
		return [] if d == nil
		row += $offset[d][0]
		col += $offset[d][1]
		here = $grid[row][col]
		#p d, here
		dist += 1
		path.append([row,col])
	end
	return path
end

path = []
'NESW'.chars.each do |d|
	path = travel(row,col,d)
	break if path.size > 0
end

lines2 = lines.map(&:chars)
p lines2

path.each do |r,c|
	#lines[r][c] = box
	lines2[r][c] = lines[r][c].box
end


def expand(lines)
	$sub = 0
	#┌─┐
	#│ │
	#└─┘
	lines2 = []
	chars = $dir.keys.join()
	lines.each do |l|
		newl = []
		l.each do |c|
			if chars[c] and c != 'S'
				newl.append(c, c)
				$sub+=1
			elsif '┌└─'[c]
				newl.append(c, '─')
			else
				newl.append(c, '.')
				$sub+=1
			end
		end
		lines2.append(newl)
	end
	lines3 = []
	width = lines2.first.size
	lines2.each do |l|
		lines3.append(l)
		newl = []
		l.each do |c|
			if chars[c] and c != 'S'
				newl.append(c)
				$sub+=1
			elsif '┌┐│'[c]
				newl.append('│')
			else
				$sub+=1
				newl.append('.')
			end
		end
		lines3.append(newl)
	end
	return lines3
end
puts lines2.map(&:join)
lines2 = expand(lines2)
puts
lines2[98*2+1][90*2] = '│'
#lines2[1][8] = '│'
puts lines2.map(&:join)

#[98, 90]

#def expand(lines)

$hack = 0

def ff(map,row,col)
	c = map[row][col]
	width = map[row].size - 1
	height = map.size - 1
	chars = $dir.keys.join()
	return 0 if c == 'S' or not chars[c]
	size = 1
	$hack += 1
	q = [[row,col]]
	all = []
	map[row][col] = ' '
	inside = true
	while not q.empty?
		row,col=q.shift
		all.append([row,col])
		inside = false if col == width or row == height or row == 0 or col == 0

		if row > 0
			c = map[row-1][col]
			if chars[c] and c != 'S'
				map[row-1][col] = ' '
				size += 1
				$hack += 1
				q.append([row-1,col])
			end
		end
		if row < height
			c = map[row+1][col]
			if chars[c] and c != 'S'
				map[row+1][col] = ' '
				size += 1
				$hack += 1
				q.append([row+1,col])
			end
		end

		if col > 0
			c = map[row][col-1]
			if chars[c] and c != 'S'
				map[row][col-1] = ' '
				size += 1
				$hack += 1
				q.append([row,col-1])
			end
		end
		if col < width
			c = map[row][col+1]
			if chars[c] and c != 'S'
				map[row][col+1] = ' '
				size += 1
				$hack += 1
				q.append([row,col+1])
			end
		end
	end

	if inside
		all.each do |r,c|
			map[r][c] = 'X'
		end
		return size
	end
	return 0
end

flood = 0
lines2.eachi do |_,i|
	_.eachi do |_,j|
		flood += ff(lines2,i,j)
	end
end

puts
puts lines2.map(&:join)
puts flood

lines3 = lines2.select.with_index {|l,i| i%2==0}
puts lines3.map(&:join)
lines4 = lines3.map{|a| a.select.with_index {|l,i| i%2==0}}
puts lines4.map(&:join)

p lines4.map{|a|a.select{|b| b=='X'}.size}.sum

puts ans.s.bold.yellow
puts 0.s.bold.green

