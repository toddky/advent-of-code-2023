#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
numbers = file.readlines.map { |i| i.scan(/\d/) }.map(&:join).to_i

time, dist = numbers

wins = 0
(1..time).each do |t|
	wins += 1 if t*(time-t) > dist
end
puts wins.s.bold.yellow

