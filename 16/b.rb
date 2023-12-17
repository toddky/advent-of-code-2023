#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
grid = file.readlines.mchars
rows, cols = grid.rows, grid.cols

def energy(grid, start)
	rows, cols = grid.rows, grid.cols
	e = Array.new(rows) { Array.new(cols,0) }

	dirs = {
		'>' => [0,1],
		'<' => [0,-1],
		'v' => [1,0],
		'^' => [-1,0],
	}

	beams = [start]
	while not beams.empty?
		new_beams = []
		beams.each do |beam|
			x,y,dir = beam
			next if x < 0 or x >= rows or y < 0 or y >= cols
			e[x][y] = 1

			c = grid[x][y]
			if '<>^v.'.include? c
				grid[x][y] = dir
				x += dirs[dir][0]
				y += dirs[dir][1]
				new_beams.append([x,y,dir]) unless dir == c
			elsif c == '|'
				if '<>'.include? dir
					new_beams.append([x-1,y,'^'])
					new_beams.append([x+1,y,'v'])
				else
					x += dirs[dir][0]
					new_beams.append([x,y,dir])
				end
			elsif c == '-'
				if '^v'.include? dir
					new_beams.append([x,y-1,'<'])
					new_beams.append([x,y+1,'>'])
				else
					y += dirs[dir][1]
					new_beams.append([x,y,dir])
				end
			elsif c == '/'
				if '>'.include? dir
					new_beams.append([x-1,y,'^'])
				elsif 'v'.include? dir
					new_beams.append([x,y-1,'<'])
				elsif '^'.include? dir
					new_beams.append([x,y+1,'>'])
				elsif '<'.include? dir
					new_beams.append([x+1,y,'v'])
				end
			elsif c == '\\'
				if '>'.include? dir
					new_beams.append([x+1,y,'v'])
				elsif 'v'.include? dir
					new_beams.append([x,y+1,'>'])
				elsif '^'.include? dir
					new_beams.append([x,y-1,'<'])
				elsif '<'.include? dir
					new_beams.append([x-1,y,'^'])
				end
			end

		end
		beams = new_beams

		#puts
		#puts grid.mjoin
	end

	#puts
	#puts e.mjoin
	return e.map(&:sum).sum
end

results = []
rows.times do |i|
	results.append(energy(grid.mdup, [i,0,'>']))
	results.append(energy(grid.mdup, [i,cols-1,'<']))
end
cols.times do |i|
	results.append(energy(grid.mdup, [0,i,'v']))
	results.append(energy(grid.mdup, [rows-1,i,'^']))
end
ans = results.max

puts ans.s.bold.yellow
puts 8185.s.bold.green
ans.clipboard

