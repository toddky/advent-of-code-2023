#!/usr/bin/env ruby

file = 'example.txt'
file = '1.txt'

p File.readlines(file).map { |line| (line[/\d/] + line.reverse[/\d/]).to_i }.inject(:+)

