#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'

class String
	def m(regex, n)
		m = regex.match(self)
		return nil if m.nil? or not m[n]
		return m[n]
	end
	def m1(regex); self.m(regex,1); end
	def m2(regex); self.m(regex,2); end
	def m3(regex); self.m(regex,3); end
end

class Array
	def to_i(); return self.map(&:to_i); end
	def max(); return self.compact.to_i.reduce { |a,b| a>b ? a : b }; end
end

sum = 0
File.readlines(file).each do |line|
	games = line.sub(/Game (\d+): +/, '')
	id = $1
	good = true

	red = 0
	green = 0
	blue = 0
	power = 0

	games.split(';').each do |game|
		puts
		p game

		green = [green, game.m1(/(\d+) green/)].max
		blue = [blue, game.m1(/(\d+) blue/)].max
		red = [red, game.m1(/(\d+) red/)].max

		power = red * blue * green
		p power
	end
	sum += power
end
p sum
p 77607

