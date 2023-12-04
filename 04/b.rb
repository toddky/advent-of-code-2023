#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts

class Integer
	def s(); self.to_s(); end
end

class String
	def i(); self.to_i; end
	# Regex
	def d?(); self =~ /^\d+$/; end
	def numbers(); self.scan(/\d+/).to_i; end
	def m(regex, n)
		m = regex.match(self)
		return nil if m.nil? or not m[n]
		return m[n]
	end
	def m1(regex); self.m(regex,1); end
	def m2(regex); self.m(regex,2); end
	def m3(regex); self.m(regex,3); end
	# Colors
	def ansi(n); "\e[#{n}m#{self}\e[0m"; end
	def bold();    ansi( 1); end
	def black();   ansi(30); end
	def red();     ansi(31); end
	def green();   ansi(32); end
	def yellow();  ansi(33); end
	def blue();    ansi(34); end
	def magenta(); ansi(35); end
	def cyan();    ansi(36); end
	def white();   ansi(37); end
end

class Array
	def to_i(); self.map(&:to_i); end
	def eachi(); self.each_with_index { |value, i| yield value, i }; end
	# Check
	def grid?(); self.map(&:size).uniq.size == 1; end
	# Reduce
	def sum(); self.compact.to_i.inject(:+); end
	def product(); self.compact.to_i.inject(:*); end
	def max(); self.compact.to_i.reduce { |a,b| a>b ? a : b }; end
	def min(); self.compact.to_i.reduce { |a,b| a<b ? a : b }; end
	# Regex
	def match_lr(i, re)
		return nil if not self[i] =~ re
		left, right = i, i
		left -= 1 while left >= 0 and self[left] =~ re
		right += 1 while right < self.size and self[right] =~ re
		return self[(left+1)..(right-1)]
	end
end

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = File.readlines(file)

sum = 0
cards = Hash.new(0)
lines.eachi do |line, i|
	want, have = line.sub(/Card +\d+: /,'').chomp.split('|').map(&:numbers)

	winning = 0
	mult = 1 + cards[i]

	have.each do |h|
		if want.include? h then
			winning += 1
			cards[winning+i] += mult
			#p cards
		end
	end

end
puts (lines.size + cards.values.sum).s.bold.yellow
puts 6227972.s.green.bold

