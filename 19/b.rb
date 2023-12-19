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

def apply(rules, xmas, label = 'in')
	#p 'rule', label, rules[label], xmas
	return [] if label == 'R'
	return [xmas.values] if label == 'A'
	parts = []
	rules[label].each do |r|
		if not r =~ /(\w)([<>])(\d+):(\w+)/
			#p 'returning', r
			return parts + apply(rules, xmas, r)
		end
		n = $3.i
		min, max = xmas[$1]

		if $2 == '<'
			next if min >= n
			label = $4
			return apply(rules, xmas, label) if max < n
			xmas2 = xmas.transform_values(&:dup)
			xmas2[$1][1] = n - 1
			xmas[$1][0] = n
			#p 'split', xmas, xmas2
			result = apply(rules, xmas2, label)
			parts += result

		elsif $2 == '>'
			next if max <= n
			label = $4
			return apply(rules, xmas, label) if min > n
			xmas2 = xmas.transform_values(&:dup)
			xmas2[$1][0] = n + 1
			xmas[$1][1] = n
			#p 'split', xmas, xmas2
			result = apply(rules, xmas2, label)
			parts += result
		end
	end
	e 'wtf'
	exit
end

xmas = Hash.new {|h,k| h[k] = [1,4000]}
'xmas'.chars.each{|x| xmas[x]}

parts = apply(rules, xmas)
ans = parts.map{|xmas| xmas.map{|x| x[1]-x[0]+1}.product}.sum

puts ans.s.bold.yellow
puts 130090458884662.s.bold.green
ans.clipboard

