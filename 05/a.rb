#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = file.readlines
seeds = lines[0].split(':')[1].numbers
lines.shift(2)

map = {}
name = ''
lines.each do |line|
	next if line.empty?

	if line =~ /map:/ then
		name = line.split(' ')[0].split('-').last
		#map[name] = (0..99).to_a
		map[name] = []
		next
	end

	a,b,c = line.numbers
	map[name].append([b,c,a])
end

order = ['soil', 'fertilizer', 'water', 'light', 'temperature', 'humidity', 'location']

def convert(map, number)
	map.each do |start, incr, new|
		if number >= start and number <= start + incr - 1 then
			return number - start + new
		end
	end
	return number
end

order.each do |item|
	new_seeds = []
	#p item, map[item]
	seeds.each do |seed|
		new_seeds.append(convert(map[item], seed))
	end
	seeds = new_seeds
end
puts seeds.min.s.bold.yellow
puts 324724204.s.bold.green

