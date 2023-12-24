#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
file = ARGV[0] || 'example.txt'
G = file.readlines.mchars
rows, cols = G.rows, G.cols unless G.rows == 0

#puts G.mjoin

nodes = {}

$g = G
$v = Array.newa(rows,cols,false)
$rows = rows
$cols = cols

$end_x = rows - 1
$end_y = cols - 1

def print_path()
	$g.eachi do |row,x|
		row.eachi do |c,y|
			if $v[x][y]
				print c.green
			else
				print c
			end
		end
		puts
	end
end

# REVISIT: This takes 5 hours to run, need to make more efficient
def visit(x,y,dist=-1)
	v = $v.point(x,y)
	c = $g.point(x,y)
	#p x, y, dist
	if x == $end_x and y == $end_y
		#p 'done', x, y, dist
		#print_path
		#puts dist
		return dist
	end
	return 0 if v.nil? or v or c == '#'
	$v[x][y] = true
	max = [
		visit(x+1,y,dist+1),
		visit(x-1,y,dist+1),
		visit(x,y+1,dist+1),
		visit(x,y-1,dist+1),
	].max
	$v[x][y] = false
	return max
end

ans = visit(0,1)

puts ans.s.bold.yellow
puts 6422.s.bold.green
ans.clipboard unless ans == 0
# Finished in 17694876 ms

