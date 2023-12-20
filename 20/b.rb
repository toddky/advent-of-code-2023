#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

lines = 'input.txt'.readlines

modules = {}
types = {}
lines.eachi do |line, i|
	m, out = line.split(' -> ')
	out = out.csv
	#p line, m, out
	if m == 'broadcaster'
		modules[m] = out
		next
	end
	modules[m[1..]] = out
	types[m[1..]] = m[0]
end

#p modules
#p types

def button(modules, types)
	state = {}
	modules.each do |m,out|
		out.each do |o|
			next unless types[o] == '&'
			state[o] ||= {}
			state[o][m] = 0
		end
	end

	magic = {}

	count = [0,0]
	i = 0
	while true
		i += 1
		count[0] += 1
		p 'count', i, magic if i % 100000 == 0
		#puts "button -0-> broadcaster"
		q = modules['broadcaster'].map{|o| [o,0,'broadcaster']}
		while not q.empty?
			m,v,from = q.shift
			#puts "#{from.ljust(3)} -#{v}-> #{m}"

			# &hp -> rx
				# &sr -> hp
				# &sn -> hp
				# &rf -> hp
				# &vq -> hp
			# REVISIT: Unhardcode this
			magic[m] ||= i if ['sr', 'sn', 'rf', 'vq'].include? m and v == 0
			return magic if magic.size == 4

			return [i] if m == 'rx' and v == 0
			count[v] += 1
			outputs = modules[m]
			if types[m] == '%'
				state[m] ||= 0
				if v == 0
					state[m] = 1 - state[m]
					q += outputs.map{|o| [o,state[m],m]}
				end
			elsif types[m] == '&'
				state[m] ||= {}
				state[m][from] = v
				send = (state[m].values.all? 1) ? 0 : 1
				q += outputs.map{|o| [o,send,m]}
			else
				#e m
				#e v
				#exit
			end
		end
	end
	return nil
end
ans = button(modules, types).values.lcm

puts ans.s.bold.yellow
puts 245114020323037.s.bold.green

ans.clipboard unless ans == 0

