#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
words = file.readlines.map(&:words)

dirs = {
	'0' => 'R',
	'1' => 'D',
	'2' => 'L',
	'3' => 'U',
}

total_dist = 0
holes = [[0,0]]
x = 0
y = 0

words.each do |dir, dist, rgb|
	offset = Dir.dirs[dirs[rgb[-2]]]
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

