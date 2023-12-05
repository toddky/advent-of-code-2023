#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = file.readlines

cards = Hash.new(0)
lines.eachi do |line, i|
	want, have = line.sub(/Card +\d+: /,'').split('|').map(&:numbers)

	winning = 0
	mult = 1 + cards[i]

	have.each do |h|
		if want.include? h then
			winning += 1
			cards[winning+i] += mult
			#p cards
		end
	end

end
puts (lines.size + cards.values.sum).s.bold.yellow
puts 6227972.s.bold.green

