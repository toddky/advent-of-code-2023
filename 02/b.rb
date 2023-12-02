#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'

sum = 0
File.readlines(file).each do |line|
	games = line.sub(/Game (\d+): +/, '')
	id = $1
	good = true

	red = 0
	green = 0
	blue = 0
	power = 0

	games.split(';').each do |game|
		puts
		p game

		m = /(\d+) green/.match(game)
		green = m[1].to_i if m and m[1].to_i > green

		m = /(\d+) blue/.match(game)
		blue = m[1].to_i if m and m[1].to_i > blue

		m = /(\d+) red/.match(game)
		red = m[1].to_i if m and m[1].to_i > red

		power = red * blue * green
		p power
	end
	sum += power
end
p sum

