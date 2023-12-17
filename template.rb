#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
file = ARGV[0] || 'example.txt'
lines = file.readlines
paragraphs = file.readlines.split('')
words = file.readlines.map(&:words)
numbers = file.readlines.map(&:numbers)
numbers = file.readlines.map(&:numbers).map(&:abs)
chars = file.readlines.mchars
csv = file.readlines.map{|line| line.split(',')}
grid = file.readlines.mchars
rows, cols = grid.rows, grid.cols
ans = 0


lines.mapi { |line, i| line }
lines.eachi do |line, i|
end


puts ans.s.bold.yellow
puts 0.s.bold.green
ans.clipboard

