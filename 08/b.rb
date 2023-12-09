#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || '2.txt'

$dirs, lines = file.readlines.split('')
$dirs = $dirs.first

$map = lines.map{|l| l.scan(/(\w\w\w)/).flatten}.map{|a| [a[0], a[1..2]]}.h

start = $map.keys.select { |k| k[2] == 'A' }
p $dirs.length
p start

def dist(start)
	ans = 0
	while start[2] != 'Z'
		$dirs.chars.each do |d|
			start = $map[start]['LR'.index(d)]
			ans += 1
			break if start[2] == 'Z'
		end
	end
	return ans
end

ans = start.map{|s| dist(s)}
p ans
ans = ans.lcm
puts ans.s.bold.yellow
puts 22289513667691.s.bold.green

