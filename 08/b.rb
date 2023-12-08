#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
#file = ARGV[0] || '2.txt'
ans = 0

lines = file.readlines
$dirs = lines[0]
lines.shift(2)

$map = {}
lines.each do |l|
	a, b, c = l.scan(/(\w\w\w)/).flatten
	$map[a] = [b, c]
end

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

p start.map{|s| dist(s)}
ans = start.map{|s| dist(s)}.lcm
puts ans.s.bold.yellow
puts 22289513667691.s.bold.green

