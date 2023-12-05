#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = File.readlines(file)

cycle = 1
x = 1
strength = 0
lines.map(&:chomp).eachi do |line, i|
	if cycle % 40 == 20 then
		puts "#{cycle}: #{(x * cycle)}".yellow
		strength += (x * cycle)
	end
	if line == 'noop' then
		cycle += 1
		next
	end

	cycle += 1
	instr, value = line.split(' ')
	if cycle % 40 == 20 then
		puts "#{cycle}: #{(x * cycle)}".yellow
		strength += (x * cycle)
	end
	cycle += 1
	x += value.i
end

puts strength.s.bold.yellow
puts 13180.s.bold.green

