#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
hands = file.readlines.map(&:splits)

def vv(a)
	return a.to_i unless a.to_i == 0
	return 10 if a == 'T'
	return  1 if a == 'J'
	return 12 if a == 'Q'
	return 13 if a == 'K'
	return 14 if a == 'A'
	puts a
	puts 'FAIL'.red
	exit 1
end

def value(a)
	a = a.gsub('J', '')
	j = 5 - a.size
	return 6 if j == 5
	return 6 if j == 4
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

def compare(a, b)
	va = value(a.sort)
	vb = value(b.sort)
	return va <=> vb unless va == vb
	a.size.times do |i|
		va = vv(a[i])
		vb = vv(b[i])
		return va <=> vb unless va == vb
	end
	return 0
end

sum = 0
hands.sort{|a,b| compare(a[0],b[0])}.eachi do |hand, i|
	#p 'hand', i+1, hand[0], hand[1].i
	sum += (hand[1].i * (i+1))
end
puts sum.s.bold.yellow
puts 250087440.s.bold.green


