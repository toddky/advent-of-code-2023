#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
time, dist = file.readlines.map(&:digits).s.mjoin.i
wins = (1..time).count { |t| t*(time-t) > dist }
puts wins.s.bold.yellow
puts 32583852.s.bold.green

