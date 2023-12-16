#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
csv = file.readlines.map{|line| line.split(',')}
ans = 0

def h(str)
	str.ascii.reduce(0) {|v,c| v = (v+c) * 17 % 256}
end
#p h('HASH')

boxes = Hash.newh
csv[0].each do |op|
	e op unless op =~ /(\w+)([=-])(\d+)?/
	box = boxes[h($1)]
	if $2 == '='
		box[$1] = $3.i
	elsif $2 == '-'
		box.delete $1
	end
end

ans = boxes.map {|box,contents| contents.values.mapi {|lens,slot| (box+1) * (slot+1) * lens}}.sum

puts ans.s.bold.yellow
puts 260530.s.bold.green

