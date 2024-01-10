#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = File.readlines(file)
rows = lines.map { |line| line.chomp.split('') }
#p rows.grid?

max_row = rows.size - 1
max_col = rows[0].size - 1

syms = /[^\.\d]/

#rows.each_with_index { |row, i| p row.join }; puts

sum = 0
rows.eachi do |row, i|

	row.eachi do |col, j|
		next unless col =~ syms

		gears = []
		if i + 1 <= max_row then
			if rows[i+1][j].d?
				gears.append(rows[i+1].match_lr(j,/\d/).join.i) if rows[i+1][j].d?
			else
				gears.append(rows[i+1].match_lr(j+1,/\d/).join.i) if rows[i+1][j+1].d?
				gears.append(rows[i+1].match_lr(j-1,/\d/).join.i) if rows[i+1][j-1].d?
			end
		end
		gears.append(rows[i].match_lr(j+1,/\d/).join.i) if rows[i][j+1].d?
		gears.append(rows[i].match_lr(j-1,/\d/).join.i) if rows[i][j-1].d?

		if i - 1 >= 0 then
			if rows[i-1][j].d?
				gears.append(rows[i-1].match_lr(j,/\d/).join.i) if rows[i-1][j].d?
			else
				gears.append(rows[i-1].match_lr(j+1,/\d/).join.i) if rows[i-1][j+1].d?
				gears.append(rows[i-1].match_lr(j-1,/\d/).join.i) if rows[i-1][j-1].d?
			end
		end

		if gears.size == 2 then
			sum += gears.product
		end
	end
end
puts sum.s.bold.yellow
puts 91031374.s.bold.green

