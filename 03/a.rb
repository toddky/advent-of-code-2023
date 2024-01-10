#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = File.readlines(file)
rows = lines.map { |line| line.chomp.split('') }
max_row = rows.size - 1
max_col = rows[0].size - 1

adj = Array.new(rows.size) { Array.new(rows[0].size) }

syms = /[^\.\d]/

rows.each_with_index do |row, i|
	row.each_with_index do |col, j|
		next unless col =~ /\d/
		if i + 1 <= max_row then
			adj[i][j] = true if rows[i+1][j+1] =~ syms
			adj[i][j] = true if rows[i+1][j  ] =~ syms
			adj[i][j] = true if rows[i+1][j-1] =~ syms
		end
		adj[i][j] = true if rows[i][j+1] =~ syms
		adj[i][j] = true if rows[i][j  ] =~ syms
		adj[i][j] = true if rows[i][j-1] =~ syms
		if i - 1 > 0 then
			adj[i][j] = true if rows[i-1][j+1] =~ syms
			adj[i][j] = true if rows[i-1][j  ] =~ syms
			adj[i][j] = true if rows[i-1][j-1] =~ syms
		end
	end
end

sum = 0
rows.each_with_index do |row, i|
	do_add = false
	digits = 0
	row.each_with_index do |col, j|
		if not col =~ /\d/
			sum += digits if do_add
			do_add = false
			digits = 0
		end

		digits = digits * 10 + col.i
		if adj[i][j] then
			do_add = true
		end
	end
	sum += digits if do_add

end

puts sum.s.bold.yellow
puts 546563.s.bold.green

