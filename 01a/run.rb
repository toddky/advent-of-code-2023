#!/usr/bin/env ruby

file = 'example.txt'
file = 'input.txt'

p File.readlines(file).map { |line| (line[/\d/] + line.reverse[/\d/]).to_i }.inject(:+)

