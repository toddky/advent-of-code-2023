#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts

# Examples:
# https://github.com/nthistle/advent-of-code/blob/7950850b77da77c1c2a4ca15c10f793c60e7ec73/2022/day25/aoc_tools.py
# https://github.com/mcpower/adventofcode/blob/15ae109bc882ca688665f86e4ca2ba1770495bb4/utils.py

require 'digest'

class Object
	def md5(); Digest::MD5.hexdigest(self.inspect); end
end

class Integer
	# String
	def a(); self.times.to_a; end
	def s(); self.to_s; end
	def rjust(n); self.s.rjust(n,'0'); end
	# Math
	#def inc(n=1); self.set(n+self); end
	def sign()
		return -1 if self < 0
		return  1 if self > 0
		return 0
	end
end

class String
	def i(); self.to_i; end
	# File
	def readlines(); File.readlines(self).map(&:chomp); end
	# Array
	def words(); self.split(/\s+/); end
	def splits(); self.split(/\s+/); end
	def sort(); self.split('').sort.join(''); end
	# Regex
	def d?(); self =~ /^-?\d+$/; end
	def numbers(); self.scan(/-?\d+/).to_i; end
	def nums(); self.scan(/-?\d+/).to_i; end
	def digits(); self.scan(/\d/).to_i; end
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
	# To
	def i(); self.map(&:to_i); end
	def s(); self.map(&:to_s); end
	def h(); Hash[self]; end
	def to_i(); self.map(&:to_i); end
	def to_s(); self.map(&:to_s); end
	def to_h(); Hash[self]; end
	def abs(); self.to_i.map(&:abs); end
	# Each
	def eachi(); self.each_with_index { |n,i| yield n, i }; end
	def mapi(); self.map.with_index { |n,i| yield n, i }; end
	def mjoin(c=''); self.map{|a| a.join(c)}; end
	def mchars(); self.map(&:chars); end
	def chunks(size); self.each_slice(size).to_a; end
	# grid.xy { |row,col| run(row,col) }
	def each_xy(); self.eachi{|_,x| _.eachi{|_,y| yield x, y }} end

	# Check
	def grid?(); self.map(&:size).uniq.size == 1; end
	def split_at(n); [self[0...n], self[n..-1]]; end
	def split(by)
		a = []
		b = []
		self.each do |v|
			if v == by
				a.append(b) unless b.empty?
				b = []
				next
			end
			b.append(v)
		end
		a.append(b) unless b.empty?
		return a
	end
	# Reduce
	def sum(); self.compact.to_i.inject(:+); end
	def product(); self.compact.to_i.inject(:*); end
	def max(); self.compact.to_i.reduce { |a,b| a>b ? a : b }; end
	def min(); self.compact.to_i.reduce { |a,b| a<b ? a : b }; end
	def lcm(); self.to_i.reduce(1,:lcm); end
	def gcd(); self.to_i.reduce(1,:gcd); end
	# Regex
	def match_lr(i, re)
		return nil if not self[i] =~ re
		left, right = i, i
		left -= 1 while left >= 0 and self[left] =~ re
		right += 1 while right < self.size and self[right] =~ re
		return self[(left+1)..(right-1)]
	end
end

class Range
	def a(); self.to_a; end
	def join(c=''); self.to_a.join(c); end
end

class Enumerator
	def a(); self.to_a; end
end

def p(string, *inputs)
	return unless $DEBUG
	file, line, _ = caller_locations.first.to_s.split(':')
	from = "[#{File.basename(file)}:#{line}]".ansi('38;5;8')
	if inputs.size > 0 then
		string = string.to_s.green
	else
		string = string.inspect
	end
	inputs.map!(&:inspect)
	inputs.map! { |str| str.size <= 2 ? str : str[0].bold.red + str[1..-2] + str[-1].bold.red }
	puts "#{from} #{string} #{inputs.join(' ')}"
end
$DEBUG = true

def e(string)
	file, line, _ = caller_locations.first.to_s.split(':')
	from = "[#{File.basename(file)}:#{line}]".ansi('38;5;8')
	puts "#{from} #{"ERROR:".bold.red} #{string.to_s}"
end

