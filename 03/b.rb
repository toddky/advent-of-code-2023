#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts

class String
	def i(); self.to_i; end
	def d?(); self =~ /^\d+$/; end
	def m(regex, n)
		m = regex.match(self)
		return nil if m.nil? or not m[n]
		return m[n]
	end
	def m1(regex); self.m(regex,1); end
	def m2(regex); self.m(regex,2); end
	def m3(regex); self.m(regex,3); end
end

class Array
	def to_i(); self.map(&:to_i); end
	def sum(); self.compact.to_i.inject(:+); end
	def product(); self.compact.to_i.inject(:*); end
	def max(); self.compact.to_i.reduce { |a,b| a>b ? a : b }; end
	def min(); self.compact.to_i.reduce { |a,b| a<b ? a : b }; end

end

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'

lines = File.readlines(file)


rows = lines.map { |line| line.chomp.split('') }


max_row = rows.size - 1
max_col = rows[0].size - 1

adj = Array.new(rows.size) { Array.new(rows[0].size) }

syms = /[^\.\d]/

#rows.each_with_index { |row, i| p row.join }; puts


def get_num(rows, i, j)
	row = rows[i]
	return nil if not row[j] =~ /\d/
	first = j
	while first >= 0 and row[first] =~ /\d/ do
		first -= 1
	end
	first += 1
	last = j
	while last < row.size and row[last] =~ /\d/ do
		last += 1
	end
	last -= 1
	return row[first..last].join.i
end


sum = 0
rows.each_with_index do |row, i|

	row.each_with_index do |col, j|
		next unless col =~ syms
		p col
		above = false
		below = false
		left = false
		right = false

		gears = []
		if i + 1 <= max_row then
			if rows[i+1][j].d?
				gears.append(get_num(rows,i+1,j))
			else
				gears.append(get_num(rows,i+1,j+1)) if rows[i+1][j+1].d?
				gears.append(get_num(rows,i+1,j-1)) if rows[i+1][j-1].d?
			end
		end
		gears.append(get_num(rows,i,j+1)) if rows[i][j+1].d?
		gears.append(get_num(rows,i,j-1)) if rows[i][j-1].d?

		if i - 1 >= 0 then
			if rows[i-1][j].d?
				gears.append(get_num(rows,i-1,j))
			else
				gears.append(get_num(rows,i-1,j+1)) if rows[i-1][j+1].d?
				gears.append(get_num(rows,i-1,j-1)) if rows[i-1][j-1].d?
			end
		end
		if gears.size == 2 then
			p gears
			sum += gears.product
		end
	end
end
p sum

