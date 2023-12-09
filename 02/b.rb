#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'

sum = 0
File.readlines(file).each do |line|
	games = line.sub(/Game (\d+): +/, '')

	red = 0
	green = 0
	blue = 0
	power = 0

	games.split(';').each do |game|
		red = [red, game.m1(/(\d+) red/)].max
		blue = [blue, game.m1(/(\d+) blue/)].max
		green = [green, game.m1(/(\d+) green/)].max
		power = red * green * blue
		#p 'game', game, power
	end
	sum += power
end
puts sum.s.bold.yellow
puts 77607.s.bold.green

