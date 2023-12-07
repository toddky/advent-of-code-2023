#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
hands = file.readlines.map(&:splits)

def rank(a)
	a = a.sort.gsub('J', '')
	j = 5 - a.size
	return 6 if j == 5 or j == 4
	# 5
	if a =~ /(.)\1\1\1\1/ then
		return 6
	# 4
	elsif a =~ /(.)\1\1\1/ then
		return 6 if j == 1
		return 5
	# FH
	elsif a =~ /(.)\1\1(.)\2/ or a =~ /(.)\1(.)\2\2/ then
		return 4
	# 3
	elsif a =~ /(.)\1\1/ then
		return 6 if j == 2
		return 5 if j == 1
		return 3
	# 2 pair
	elsif a =~ /(.)\1.*(.)\2/ then
		return 4 if j == 1
		return 2
	# 2
	elsif a =~ /(.)\1/ then
		return 6 if j == 3
		return 5 if j == 2
		return 3 if j == 1
		return 1
	# High, just jacks
	elsif j == 3
		return 5
	elsif j == 2
		return 3
	elsif j == 1
		return 1
	end
	return 0
end

def value(a)
	order = 'J' + (2..9).join + 'TQKA'
	v = a.chars.map{|n| order.index(n)}.map{|c| c.rjust(2)}.join.i
	v += 10**10 * rank(a)
	return v
end

sum = 0
hands.sort_by{|n| value(n[0])}.eachi do |hand, i|
	#p 'hand', i+1, hand[0], hand[1].i
	sum += (hand[1].i * (i+1))
end
puts sum.s.bold.yellow
puts 250087440.s.bold.green

