#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'

sum = 0
File.readlines(file).each do |line|
	games = line.sub(/Game (\d+): +/, '')
	id = $1
	good = true
	games.split(';').each do |game|
		good = false if [0, game.m1(/(\d+) red/)].max > 12
		good = false if [0, game.m1(/(\d+) green/)].max > 13
		good = false if [0, game.m1(/(\d+) blue/)].max > 14
	end
	sum += id.to_i if good
end

puts sum.s.bold.yellow
puts 2679.s.bold.green

