#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
words = file.readlines.map(&:words)
numbers = file.readlines.map(&:numbers)
chars = file.readlines.map(&:chars)
ans = 0



puts ans.s.bold.yellow
puts 0.s.bold.green

