#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'
lines = file.readlines
seeds = lines[0].split(':')[1].numbers
#seeds = seeds.each_slice(2).to_a.map { |a,b| [a,a+b-1] }
seeds = seeds.chunks(2).map { |a,b| [a,a+b-1] }
lines.shift(2)

map = {}
name = ''
lines.each do |line|
	next if line.empty?
	if line =~ /map:/ then
		name = line.split(' ')[0].split('-').last
		map[name] = []
		next
	end
	a,b,c = line.numbers
	map[name].append([b,b+c-1,a-b])
end

order = ['soil', 'fertilizer', 'water', 'light', 'temperature', 'humidity', 'location']

def convert(map, number)
	map.each do |first, last, incr|
		if number >= first and number <= last then
			return number - incr
		end
	end
	return number
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
	#soils.each do |soil_lo, soil_hi, incr|
	new_soils = []
	again = true
	while again
		again = false
		new_new_soils = []
		soils.each do |soil|
			new_seeds = []
			seeds.each do |seed|
				a, b = splitter(seed, soil)
				#puts 'ab'.red + " #{a} #{b}"
				new_seeds += a
				new_new_soils += b
			end
			seeds = new_seeds.uniq
		end
		break if new_new_soils.empty?
		new_soils += new_new_soils
	end
	#puts "seeds".red + " #{new_soils} #{seeds}"
	return new_soils + seeds
end

#p seeds
#p map['soil']
#puts
#p split_ranges(seeds, map['soil'])
#p split_ranges(seeds, map['soil']).uniq

order.each do |item|
	#puts item.bold.yellow
	item_range = map[item]
	#p seeds
	#p item_range
	#p to_soil(seeds, item_range)
	#exit
	seeds = to_soil(seeds, item_range).uniq
	#puts "seeds".red
	#p seeds
end
p seeds.map(&:first).uniq.min

