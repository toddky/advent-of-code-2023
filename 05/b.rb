#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = file.readlines
seeds = lines[0].split(':')[1].numbers
seeds = seeds.chunks(2).map { |a,b| [a,a+b-1] }
lines.shift(2)

map = {}
names = []
name = ''
lines.each do |line|
	next if line.empty?
	if line =~ /map:/ then
		name = line.split(' ')[0]
		names.append(name)
		map[name] = []
		next
	end
	a,b,c = line.numbers
	map[name].append([b,b+c-1,a-b])
end

def splitter(seed, soil)
	seeds = []
	soils = []
	seed_lo, seed_hi = seed
	soil_lo, soil_hi, incr = soil
	#[aa]bb
	#[a][ba]b
	#[a][bb][a]
	if seed_lo < soil_lo then
		if seed_hi < soil_lo then
			seeds.append([seed_lo, seed_hi])
		elsif seed_hi < soil_hi then
			seeds.append([seed_lo, soil_lo-1])
			soils.append([soil_lo+incr, seed_hi+incr])
		else
			seeds.append([seed_lo, soil_lo-1])
			soils.append([soil_lo+incr, soil_hi+incr])
			seeds.append([soil_hi+1, seed_hi])
		end

	#b[aa]b
	#b[a][ba]
	elsif seed_lo <= soil_hi
		if seed_hi <= soil_hi then
			soils.append([seed_lo+incr, seed_hi+incr])
		else
			soils.append([seed_lo+incr, soil_hi+incr])
			seeds.append([soil_hi+1, seed_hi])
		end

	#bb[aa]
	else
		seeds.append([seed_lo, seed_hi])
	end
	return seeds, soils
end

def to_soil(seeds, soils)
	new_soils = []
	soils.each do |soil|
		new_seeds = []
		seeds.each do |seed|
			a,b = splitter(seed, soil)
			#puts 'ab'.red + " #{a} #{b}"
			new_seeds += a
			new_soils += b
		end
		seeds = new_seeds.uniq
	end
	#p "new seeds", new_soils + seeds
	return new_soils + seeds
end

names.each do |item|
	item_range = map[item]
	seeds = to_soil(seeds, item_range).uniq
end
puts seeds.map(&:first).min.s.bold.yellow
puts 104070862.s.bold.green

