#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
hands = file.readlines.map(&:splits)

def rank(a)
	a = a.sort
	# 5
	if a =~ /(.)\1\1\1\1/ then
		return 6
	# 4
	elsif a =~ /(.)\1\1\1/ then
		return 5
	# FH
	elsif a =~ /(.)\1\1(.)\2/ or a =~ /(.)\1(.)\2\2/ then
		return 4
	elsif a =~ /(.)\1\1/ then
		return 3
	# 2 pair
	elsif a =~ /(.)\1.*(.)\2/ then
		return 2
	elsif a =~ /(.)\1/ then
		return 1
	end
	return 0
end

def value(a)
	order = (2..9).join + 'TJQKA'
	v = a.chars.map{|n| order.index(n)}.map{|c| c.rjust(2)}.join.i
	v += 10**10 * rank(a)
	return v
end

sum = 0
hands.sort_by{|n| value(n[0])}.eachi do |hand, i|
	#p 'hand', i+1, hand[0], value(hand[0]), hand[1].i
	sum += (hand[1].i * (i+1))
end
puts sum.s.bold.yellow
puts 250254244.s.bold.green


