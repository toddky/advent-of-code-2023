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
		name = line.split(' ')[0]
		map[name] = (0..99).to_a
		next
	end

	a, b, c = line.numbers
	(b..(b+c-1)).each_with_index do |d, i|
		map[name][d] = a + i
	end
end

lowest
loc = []
seeds.map do |seed|
	a = map['seed-to-soil'][seed]
	b = map['soil-to-fertilizer'][a]
	c = map['fertilizer-to-water'][b]
	d = map['water-to-light'][c]
	e = map['light-to-temperature'][d]
	f = map['temperature-to-humidity'][e]
	g = map['humidity-to-location'][f]
	loc.append(g)
end

p loc.sort




