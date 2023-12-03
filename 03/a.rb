#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts

class String
	def i(); self.to_i; end
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


rows.each_with_index do |row, i|
	#p row.join
	#p row
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
			p digits if do_add
			do_add = false
			#p digits if digits != 0
			digits = 0
		end

		digits = digits * 10 + col.i
		if adj[i][j] then
			do_add = true
		end
	end
	sum += digits if do_add

end
p sum
exit


rows.each_with_index do |row, i|
	row.each_with_index do |col, j|
		if adj[i][j] then
			print("\e[33m#{col}\e[0m")
		else
			print(col)
		end
	end
	puts
end


#puts
#adj.each_with_index do |row, i|
	#row = row.map { |a| a.nil? ? '_' : '#' }
	#p row.join
#end

