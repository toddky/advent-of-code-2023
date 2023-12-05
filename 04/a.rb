#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = File.readlines(file)

sum = 0
lines.eachi do |line, i|
	want, have = line.sub(/Card +\d+: /,'').chomp.split('|')
	winning = (want.numbers & have.numbers).size
	next if winning == 0
	#puts (2**(winning-1)).s.yellow
	sum += (2**(winning-1))
end
puts sum.s.bold.yellow
puts 26426.s.bold.green

