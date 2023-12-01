#!/usr/bin/env ruby
file = ARGV[0] || 'input.txt'
p File.readlines(file).map { |line|
  line.gsub('one','one1one')
    .gsub('two','two2two')
    .gsub('three','three3three')
    .gsub('four','four4four')
    .gsub('five','five5five')
    .gsub('six','six6six')
    .gsub('seven','seven7seven')
    .gsub('eight','eight8eight')
    .gsub('nine','nine9nine')
    .gsub('zero','zero0zero')
}.map { |line| (line[/\d/] + line.reverse[/\d/]).to_i }.inject(:+)

