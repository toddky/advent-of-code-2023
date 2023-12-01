#!/usr/bin/env ruby
file = ARGV[0] || 'input.txt'
p File.readlines(file).map { |line| (line[/\d/] + line.reverse[/\d/]).to_i }.inject(:+)
