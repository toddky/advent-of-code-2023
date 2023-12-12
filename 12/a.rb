#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
words = file.readlines.map(&:words)
chars = file.readlines.map(&:chars)
ans = 0

#p chars.map{|c|c.count('?')}.max
#p chars.map{|c|c.count(',')}.max

def all(line)
	c = line.count('?')
	n = 2**(line.count('?'))
	n.times.each do |i|
		l = line
		sub = i.to_s(2).rjust(c,'0').reverse.gsub('1','#').gsub('0','.')
		c.times.each do |i|
			l = l.sub('?',sub[i])
		end
		yield l.split('.').select{|s| not s.empty?}.map(&:size)
	end
end

i = 0
words.each do |springs, pattern|
	i += 1
	puts i
	count = 0
	pattern = pattern.split(',').i
	all(springs) do |spring|
		count += 1 if pattern == spring
	end
	#p 'count', count, springs, pattern
	ans += count
end

puts ans.s.bold.yellow
puts 7163.s.bold.green

