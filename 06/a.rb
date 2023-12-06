#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
numbers = file.readlines.map(&:numbers).transpose
ans = numbers.map { |time, dist| (1..time).count { |t| t*(time-t) > dist } }.product
puts ans.s.bold.yellow
puts 1624896.s.bold.green

