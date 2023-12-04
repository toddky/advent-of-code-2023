#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts

class Integer
	def s(); self.to_s(); end
end

class String
	def i(); self.to_i; end
	# Regex
	def d?(); self =~ /^\d+$/; end
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
		left = i
		left -= 1 while left >= 0 and self[left] =~ re
		left += 1
		right = i
		right += 1 while right < self.size and self[right] =~ /\d/
		right -= 1
		return self[left..right]
	end
end

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = File.readlines(file)
rows = lines.map { |line| line.chomp.split('') }
#p rows.grid?

max_row = rows.size - 1
max_col = rows[0].size - 1

syms = /[^\.\d]/

#rows.each_with_index { |row, i| p row.join }; puts

sum = 0
rows.eachi do |row, i|

	row.eachi do |col, j|
		next unless col =~ syms

		gears = []
		if i + 1 <= max_row then
			if rows[i+1][j].d?
				gears.append(rows[i+1].match_lr(j,/\d/).join.i) if rows[i+1][j].d?
			else
				gears.append(rows[i+1].match_lr(j+1,/\d/).join.i) if rows[i+1][j+1].d?
				gears.append(rows[i+1].match_lr(j-1,/\d/).join.i) if rows[i+1][j-1].d?
			end
		end
		gears.append(rows[i].match_lr(j+1,/\d/).join.i) if rows[i][j+1].d?
		gears.append(rows[i].match_lr(j-1,/\d/).join.i) if rows[i][j-1].d?

		if i - 1 >= 0 then
			if rows[i-1][j].d?
				gears.append(rows[i-1].match_lr(j,/\d/).join.i) if rows[i-1][j].d?
			else
				gears.append(rows[i-1].match_lr(j+1,/\d/).join.i) if rows[i-1][j+1].d?
				gears.append(rows[i-1].match_lr(j-1,/\d/).join.i) if rows[i-1][j-1].d?
			end
		end

		if gears.size == 2 then
			sum += gears.product
		end
	end
end
puts sum.s.yellow
puts 91031374.s.green

