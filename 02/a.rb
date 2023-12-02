#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'

sum = 0
File.readlines(file).each do |line|
	games = line.sub(/Game (\d+): +/, '')
	id = $1
	good = true
	games.split(';').each do |game|
		p game
		m = /(\d+) red/.match(game)
		good = false if m and m[1].to_i > 12
		m = /(\d+) green/.match(game)
		good = false if m and m[1].to_i > 13
		m = /(\d+) blue/.match(game)
		good = false if m and m[1].to_i > 14
	end
	sum += id.to_i if good
end
p sum

