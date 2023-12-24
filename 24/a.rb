#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

file = ARGV[0] || 'input.txt'
min, max = 200000000000000, 400000000000000
#file = ARGV[0] || 'example.txt'
#min, max = 7, 27
L = file.readlines
ans = 0

H = L.map{|l| l.split('@').map(&:numbers)}

def mb(x1,y1,x2,y2)
	m = (y2-y1).to_f/(x2-x1)
	b = y1-(m*x1)
	return m, b
end

def forward(x,x1,vx1)
	(vx1 > 0 and x > x1) or (vx1 < 0 and x < x1) or (vx1 == 0)
end

H[0..-2].eachi do |pv1,i|
	# y = mx + b
	p1,v1 = pv1
	x1,y1,z1 = p1
	vx1,vy1,vz = v1
	
	m1,b1 = mb(x1, y1, x1+vx1, y1+vy1)
	#p m1, b1

	H[(i+1)..-1].each do |pv2|
		p2,v2 = pv2
		x2,y2,z2 = p2
		vx2,vy2,vz = v2
		m2,b2 = mb(x2, y2, x2+vx2, y2+vy2)

		next if m1 == m2
		x = (b2-b1) / (m1-m2)
		y = m1 * x + b1

		#p 'intersect', x, y, m1, m2
		if x >= min and x <= max and y >= min and y <= max
			if forward(x,x1,vx1) and forward(x,x2,vx2)
				ans += 1
			end
		end
	end
end

puts ans.s.bold.yellow
puts 13965.s.bold.green
ans.clipboard unless ans == 0

