#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
csv = file.readlines.map{|line| line.split(',')}
ans = 0

def h(str)
	v = 0
	str.ascii.each do |c|
		v += c
		v *= 17
		v %= 256
	end
	return v
end
#p h('HASH')

box = {}
csv[0].each do |op|
	label, value = op.split(/[=-]/)
	if op['=']
		i = h(label)
		box[i] ||= {}
		box[i][label] = value.i
	elsif op['-']
		box.each do |box_num, b|
			b.delete label if b.key? label
		end
	else
		p 'wtf', op
		exit 1
	end
	#p op, i, box
end

box.each do |i, stuff|
	stuff.keys.eachi do |slot, j|
		ans += (i+1) * (j+1) * stuff[slot]
	end
end

puts ans.s.bold.yellow
puts 260530.s.bold.green

