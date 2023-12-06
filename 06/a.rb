#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
numbers = file.readlines.map(&:numbers).transpose

prod = 1
numbers.eachi do |n, i|
	time, dist = n
	p i, time, dist
	wins = 0
	(1..time).each do |t|
		wins += 1 if t*(time-t) > dist
	end
	p wins
	prod *= wins
end
puts prod.s.bold.yellow

