#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'

boxes = Hash.newh
file.readlines.map{|l|l.split(',')}[0].each { |op|
	op =~ /(\w+)([=-])(\d+)?/
	b = boxes[$1.chars.reduce(0){|v,c| v=(v+c.ord)*17%256}]
	if $2 == '='
		b[$1] = $3.i
	elsif $2 == '-'
		b.delete $1
	end
}

puts boxes.map{|n,b| b.values.mapi{|l,s| (n+1)*(s+1)*l}}.sum
puts 260530.s.bold.green

