#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = file.readlines
paragraphs = file.readlines.split('')

rules = {}
paragraphs[0].each do |line|
	name = line.split('{')[0]
	parts = line.m1(/{(.*)}/).split(',')
	rules[name] = parts
end

def apply(rules, xmas)
	label = 'in'
	xmas = 'xmas'.chars.zip(xmas).to_h
	while true
		return xmas.values.sum if label == 'A'
		return 0 if label == 'R'
		rule = rules[label]
		#p 'rule', rule, label
		label = rule.last
		rule.each do |r|
			next unless r =~ /(\w)([<>])(\d+):(\w+)/
			n = xmas[$1]
			if $2 == '<' and n < $3.i
				label = $4
				break
			elsif $2 == '>' and n > $3.i
				label = $4
				break
			end
		end
	end
end

ans = paragraphs[1].map { |parts| apply(rules,parts.numbers) }.sum

puts ans.s.bold.yellow
puts 446517.s.bold.green
ans.clipboard

