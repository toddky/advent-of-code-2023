#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts

# ==============================================================================
# EXAMPLES
# ==============================================================================
# Ruby:
# - https://github.com/globalreset/advent_of_code_2023/tree/main/shared
# - https://github.com/globalreset/advent_of_code_2023/blob/main/shared/grid.rb
# Python:
# - https://github.com/mebeim/aoc/tree/master/utils
# - https://github.com/jarshwah/advent-of-code/blob/main/python/utils.py
# - https://github.com/nthistle/advent-of-code/blob/7950850b77da77c1c2a4ca15c10f793c60e7ec73/2022/day25/aoc_tools.py
# - https://github.com/mcpower/adventofcode/blob/15ae109bc882ca688665f86e4ca2ba1770495bb4/utils.py
# Other:
# - https://github.com/sbiickert/AdventOfCode2023/blob/main/Swift/AoC%202023/AoC%202023/Libraries/AoCGrid2D.swift


# ==============================================================================
# TIMER
# ==============================================================================
start_time =  Process.clock_gettime(Process::CLOCK_MONOTONIC)
at_exit {
	stop_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
	puts "Finished in #{((stop_time - start_time) * 1000).round(0)} ms"
}


# ==============================================================================
# REQUIRE
# ==============================================================================
require 'base64'
require 'digest'


# ==============================================================================
# DEFAULT
# ==============================================================================
class Object
	def md5(); Digest::MD5.hexdigest(self.inspect); end
	def base64(); Base64.encode64("#{self}\n"); end
	def clipboard()
		print "\e]52;c;#{self.base64}\a"
		puts "Copied #{self.to_s.bold.yellow} to clipboard"
	end
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
	def ascii(); self.codepoints; end
	# File
	def readlines(); File.readlines(self).map(&:chomp); end
	# Array
	def csv(); self.split(/\s*,\s*/); end
	def words(); self.split(/\s+/); end
	def splits(); self.split(/\s+/); end
	def sort(); self.split('').sort.join(''); end
	# Regex
	def in?(string); string.include? self; end
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
	def clean(); self.flatten.compact; end
	# New
	def Array.newa(rows,cols,value=nil); Array.new(rows) { cols.nil? ? Array.new : Array.new(cols, value) }; end
	def Array.newh(size); Array.new(size) { Hash.new }; end

	# Get
	# Huge performance slowdown for 2023-16b, but it works
	#def [](n); n.class == Array ? self.at(n[0]).at(n[1]) : self.at(n); end
	#def get(*n); self.at(n.flatten[0]).at(n.flatten[1]); end
	def get(n); self.at(n[0]).at(n[1]); end
	def rows(); self.size; end
	def cols(); self[0].size; end

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
	#def chunks(size); self.each_slice(size).to_a; end
	def chunks_of(size); self.each_slice(size).to_a; end
	# grid.xy { |row,col| run(row,col) }
	def each_xy(); self.eachi{|_,x| _.eachi{|_,y| yield x, y }} end

	# Map
	def add(other); self.map.with_index { |n,i| n + other[i] }; end
	def mapi(); self.map.with_index { |n,i| yield n, i }; end
	def mchars(); self.map(&:chars); end
	def mdup(); self.map(&:dup); end
	def mneg(); self.map{|n|-n}; end
	def mjoin(c=''); self.map{|a| a.join(c)}; end
	def mreverse(); self.map(&:reverse); end

	# Select
	def mod(div, rem); self.select.with_index{|_,i| i%div==rem}; end

	# Rotate
	def cw(); self.transpose.mreverse; end
	def ccw(); self.mreverse.transpose; end

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
	def sum(); self.clean.to_i.inject(:+) || 0; end
	def product(); self.clean.to_i.inject(:*); end
	def prod(); self.clean.to_i.inject(:*); end
	def max(); self.clean.to_i.reduce { |a,b| a>b ? a : b }; end
	def min(); self.clean.to_i.reduce { |a,b| a<b ? a : b }; end
	def lcm(); self.to_i.reduce(1,:lcm); end
	def gcd(); self.to_i.reduce(1,:gcd); end

	# Grid
	def point(x, y)
		return (x < 0 or x >= self.size or y < 0 or y >= self[x].size) ? nil : self[x][y]
	end

	# Point
	def x; self[0]; end
	def y; self[1]; end
	def move(dir); [self[0]+dir[0], self[1]+dir[1]]; end
	def up   ; self.move(Dir.N); end
	def right; self.move(Dir.E); end
	def down ; self.move(Dir.S); end
	def left ; self.move(Dir.W); end

	# Direction
	def backwards(); self.map{|n|-n}; end

	# Regex
	# REVISIT: Do I need this?
	def match_lr(i, re)
		return nil if not self[i] =~ re
		left, right = i, i
		left -= 1 while left >= 0 and self[left] =~ re
		right += 1 while right < self.size and self[right] =~ re
		return self[(left+1)..(right-1)]
	end
end

class Hash
	# REVISIT:
	# https://github.com/globalreset/advent_of_code_2023/blob/899228feda60575f56b76e0335b4c7a22885df63/shared/util.rb#L2

	# New
	def Hash.newa(); Hash.new { |hash, key| hash[key] = [] }; end
	def Hash.newh(); Hash.new { |hash, key| hash[key] = {} }; end
end

class Range
	def a(); self.to_a; end
	def join(c=''); self.to_a.join(c); end
end

class Enumerator
	def a(); self.to_a; end
end


# ==============================================================================
# CUSTOM
# ==============================================================================
class Dir
	N = [-1, 0]
	S = [ 1, 0]
	E = [ 0, 1]
	W = [ 0,-1]
	DIRS = {
		'N' => N,
		'E' => E,
		'S' => S,
		'W' => W,
		'U' => N,
		'R' => E,
		'D' => S,
		'L' => W,
		'^' => N,
		'>' => E,
		'v' => S,
		'<' => W,
	}
	def Dir.U    ; N; end
	def Dir.D    ; S; end
	def Dir.R    ; E; end
	def Dir.L    ; W; end
	def Dir.up   ; N; end
	def Dir.down ; S; end
	def Dir.right; E; end
	def Dir.left ; W; end
	def Dir.N    ; N; end
	def Dir.S    ; S; end
	def Dir.E    ; E; end
	def Dir.W    ; W; end
	def Dir.dirs ; Dir::DIRS; end
end
D4 = [Dir.U,Dir.D,Dir.L,Dir.R]


# ==============================================================================
# FUNCTIONS
# ==============================================================================
def p(string, *inputs)
	return unless $DEBUG
	file, line, _ = caller_locations.first.to_s.split(':')
	#from = "[#{File.basename(file)}:#{line}]".ansi('38;5;8')
	from = "[#{File.basename(file)}:".ansi('38;5;8')
	from += line.cyan + ']'.ansi('38;5;8')
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

def memoize(name, *args)
	@cache ||= {}
	@cache[name] ||= {}
	orig_name = "orig_#{name}".to_sym
	eval "alias #{orig_name} #{name}"
	send(:define_method, name) do |*args|
		return @cache[name][*args] if @cache[name][*args]
		@cache[name][*args] ||= method(orig_name).call *args
	end
end

# Cantor pairing function
# https://en.wikipedia.org/wiki/Pairing_function#Cantor_pairing_function
def pair(x, y)
	return (x + y) * (x + y + 1) / 2 + y
end
def unpair(z)
	w = ((Math.sqrt(8 * z + 1) - 1) / 2).floor
	t = (w**2 + w) / 2
	y = z - t
	x = w - y
	return [x, y]
end

