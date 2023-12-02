#!/usr/bin/env ruby
file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'

sum = 0
File.readlines(file).each { |line|
  games = line.sub(/Game (\d+): +/, '')
  id = $1
  good = true

  red = 0
  green = 0
  blue = 0
  power = 0

  games.split(';').each { |game| 
    puts
    p game

    m = /(\d+) green/.match(game)
    if m then
      if m[1].to_i > green then
        green = m[1].to_i
      end
    end

    m = /(\d+) blue/.match(game)
    if m then
      if m[1].to_i > blue then
        blue = m[1].to_i
      end
    end

    m = /(\d+) red/.match(game)
    if m then
      if m[1].to_i > red then
        red = m[1].to_i
      end
    end

    power = red * blue * green
    p power

  }
  sum += power
}
p sum

