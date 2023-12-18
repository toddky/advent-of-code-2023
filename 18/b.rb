#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
start =  Process.clock_gettime(Process::CLOCK_MONOTONIC)
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
words = file.readlines.map(&:words)
grid = file.readlines.mchars
rows, cols = grid.rows, grid.cols unless grid.rows == 0
ans = 0

r = [0,1]
l = [0,-1]
u = [-1,0]
d = [1,0]

dirs = {
	'0' => r,
	'1' => d,
	'2' => l,
	'3' => u,
}

total_dist = 0
holes = [[0,0]]
x = 0
y = 0
words.each do |dir, dist, rgb|
	dir = rgb[-2]
	offset = dirs[dir]
	dist = rgb[2..6].to_i(16)
	total_dist += dist
	x += dist*offset[0]
	y += dist*offset[1]
	holes.append([x,y])
end
$dist = total_dist


class Array
	def shoelace
		sum = 0
		self.push(self[0])
		size = self.length
		(0...size-1).each do |i|
			sum += (self[i][0] * self[i + 1][1]) - (self[i + 1][0] * self[i][1])
		end
		self.pop()
		sum = (sum.abs.to_f / 2.0).round(2)
		sum += $dist/2 + 1
		return sum.abs.to_i
	end
end

ans = holes.shoelace

puts ans.s.bold.yellow
puts 134549294799713.s.bold.green
ans.clipboard
stop = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "Finished in #{((stop - start) * 1000).round(0)} ms"

